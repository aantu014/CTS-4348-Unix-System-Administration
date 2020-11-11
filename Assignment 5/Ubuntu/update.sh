count=0
def_port=7766

cat <<EOF > /etc/haproxy/haproxy.cfg
global
    log 127.0.0.1 local0 notice
    maxconn 2000
    user haproxy
    group haproxy

defaults
    log     global
    mode    tcp			
    timeout connect  5000
    timeout client  10000
    timeout server  10000
EOF

cat aantu014.csv | cut -d "," -f9 | xargs -n1 | sort -u  | while IFS="," read o;
do
  port=$((def_port+$count))
  maxp=7785
  if [ "$port" -le "$maxp" ];then
cat << EOF >> "/etc/haproxy/haproxy.cfg"

frontend  $o
    bind :$port
    default_backend $o

backend $o
    balance     roundrobin
    server  ${o}1 10.128.1.176:$((port + 1100))
    server  ${o}2 10.128.1.177:$((port + 2200))
EOF
  fi
  count=$count+1
done
