#!/usr/bin/env bash
# A simple bash script for rdiff-backup.
# requires ssh key based authentication 

### BEGIN INIT ###
verbose=1 # set verbose level
host_dir='/some/remote/path' # directory on remote host
local_dir='/some/local/path'
begin_time=$(date +%Y-%m-%d) # today's date
error="$0: Backup of ${host_dir:-'target'} failed."
success="$0: Backup of ${host_dir:-'target'} successful."
options=("Run rdiff-backup" "Print Statistics")
PS3="Select option or ($(expr ${#options[@]} + 1)) to exit:"
### END INIT ###

function run_backup() {
    local host='myhost'
    local backup_user='myuser'
    $(/usr/bin/rdiff-backup -v"$verbose" \
    "${backup_user}"@"${host}"::"${remote_dir}" "${local_dir}")
}

# Is shell interactive? Yes:[display prompt] No:[run_backup]
if [ -n "$PS1" ]; then
    run_backup
    [ "$?" -gt "0" ] && logger "${error}" || logger "${success}"
else

select option in "${options[@]}" "Quit";
do
    case $option in
        "Run rdiff-backup")
            if [ -x "/usr/bin/rdiff-backup" ] && [ -d "${local_dir}" ]; then
                run_backup
                [ "$?" -gt "0" ] && echo "${error}" || echo "${success}"
            else
                echo "rdiff-backup not found or local directory inaccessible"
            fi
            ;;
        "Print Statistics")
            rdiff-backup-statistics --begin-time "${begin_time}" "${local_dir}" 
            ;;
        "Quit") break ;;
        *) echo "Invalid option selected";;
    esac
done
fi
