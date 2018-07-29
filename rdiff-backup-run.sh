#!/usr/bin/env bash

### BEGIN INIT ###
host_dir='/path/remote/dir' # directory on remote host
local_dir='/path/local/dir' # directory to store backups
begin_time=$(date +%Y-%m-%d) # ignore logs before today's date
menu_options=("Run rdiff-backup" "Print Statistics")
PS3="Select option or ($(expr ${#menu_options[@]} + 1)) to exit: "
### END INIT ###

run_backup() {
    local cmd_options="-v1"
    local host='myhost'
    local backup_user='myuser'
    $(/usr/bin/rdiff-backup "${cmd_options}" \
    "${backup_user}"@"${host}"::"${host_dir}" "${local_dir}")
}

get_statistics() {
    local stat_options="--begin-time ${begin_time} --quiet"
    /usr/bin/rdiff-backup-statistics $stat_options "${local_dir}"
}

# Are we running interactively?
if [ -n "$PS1" ]; then
    run_backup
    [ "$?" -gt "0" ] && logger "Backup Failed." \
    || logger "Backup was successful"
else

# Display prompt to user
select option in "${menu_options[@]}" "Quit";
do
    case $option in
        "Run rdiff-backup")
            # Check path of binary and local storage
            if [ -x "/usr/bin/rdiff-backup" ] && [ -d "${local_dir}" ]; then
                run_backup
                [ "$?" -gt "0" ] && printf "rdiff-backup failed, please check log" \
                || printf "rdiff-backup was successful. \n"
            else
                printf "rdiff-backup not found or local path inaccessible"
            fi
            ;;
        "Print Statistics")
            get_statistics
            ;;
        "Quit") break ;;
        *) printf "Invalid option selected \n";;
    esac
done
fi
