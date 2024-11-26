# test-connectivity.sh
#!/bin/bash
PUBLIC_IP=$1
echo "Testing SSH connectivity on $PUBLIC_IP..."
telnet $PUBLIC_IP 22