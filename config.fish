if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test "$IS_AUTOLAUNCH" = "1"
    echo "IS_AUTOLAUNCH is set to 1, launch monitor..."
    ssh -t guest@10.251.171.6 -p51122 "tmux attach -t monitor; bash"
end
