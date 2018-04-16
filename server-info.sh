#!/bin/bash

# Generate server HTML report

dest="/var/www/html/index.html"

# Empty previous contents
> "$dest"

cat <<EOF >> "$dest"
<!DOCTYPE html>

<html>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>$(hostname) summary</title>

<body>

<div class="w3-container w3-red w3-padding"><h1>$(hostname) server summary</h1></div>

<div class="w3-container w3-blue"><h2>Package status</h2></div>
<div class="w3-container w3-margin-bottom"><h4>$(apt update &> /tmp/apt && tail -n 1 /tmp/apt)</h4></div>

<div class="w3-container w3-blue"><h2>Kernel version</h2></div>
<div class="w3-container w3-margin-bottom"><h4>$(uname -rvm)</h4></div>

<div class="w3-container w3-blue"><h2>SSH hostkey fingerprints</h2></div>
<div class="w3-container"><h4>$(ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub | cut -d ' '  -f1-2,4-)</h4></div>
<div class="w3-container w3-margin-bottom"><h4>$(ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub | cut -d ' '  -f1-2,4-)</h4></div>

<div class="w3-container w3-blue"><h2>Uptime</h2></div>
<div class="w3-container w3-margin-bottom"><h4>$(uptime)</h4></div>

<div class="w3-container w3-blue"><h2>Backup</h2></div>
<div class="w3-container w3-margin-bottom"><h4>dsmcad service is $(systemctl is-active dsmcad)</h4></div>
</body>

</html>
EOF

exit 0
