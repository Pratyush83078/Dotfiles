# Systemd
    
    - It is an "init system" 
    - init system most important process running on server  (pid 1) 
    - It manages all services that run in the background (htop pid1)
    - service vs unit 
    - priority /etc/systemd/system/ then /run/systemd/system/(runtime services) then /lib/systemd/system/
    - systemctl edit --full
    - systemctl daemon-reload
    - systemd as a timer (cronjob replacement)
