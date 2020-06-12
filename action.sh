case $1 in

  # alarm_status motion_probability fps
  alarm)
    echo "ALARM $2" >&2
    # TODO: place notification code here
  ;;

  # fname scene_change fps
  record) # NB: mjpeg stream as stdin
    echo "ALARM RECORD SCENE_CHANGE=$3 FPS=$4" >&2
    # TODO: place recording code here
  ;;

esac
