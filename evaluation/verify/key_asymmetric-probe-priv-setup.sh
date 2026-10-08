#!/usr/bin/env bash
# Introspection SETUP: create a Key entity ka_probe_priv of type asymmetric_private holding a real
# RSA private key, so an agent can inspect its key type on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
PEM=/tmp/key_asymmetric_probe_priv.pem
cat > "$PEM" <<'PEMEOF'
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDhGjhPwP8OSWjC
WaDb3HkXsBsZkotbS/CPZYrm7PQpuxhdFG+GGudxDtMjpqWs/qJzGDX17EMmpwqk
Nxirnrd8ZLtguHiX0c6qcaNn3n5pbdn49Wiad5g0XScsopeA5UV4qkXKE5N4kmPf
4h7TGJLdC9aScNwbdwI/lRaQSWPUFDU+DE2zXEQX0uMXmyVtI/1oxyHQ+m++beNS
0I6LlNvXZWilNwjJLXxn2ysMgqaUcSDFovNy0wgEcqlmgqV9VJvjzPEqE015ONh6
OEQj9AKzGvZwVYFXJ93HaN2E1qMLLPrK4A1nS94FcHcYIScdA4R+Gkkg+MdXF4Re
t36tDO2ZAgMBAAECggEAJWP7kpPWSgM7mXzV0W9v1dV0yuyipUmZ7dfKGM2nSP9A
7sUkOTxi0U7LF5Lo1jF9vmx5Gh5ikRsSE3DrciZtCAabcVdzAJTjJUC3CdvVV6Hd
oRLyiyXubFRE248uZ0SuI3r1GLnjtxVp7Zhb0mi0jG8Y9z4z8YP1JaaYFuN555Ib
4fRf45AGWFUCtezPQp3Y9hwa6FuSXX0nOpUJ16qJkR45XqDzAv2mvFBybnuIgESH
8kpwJHBBCsyyCGUR8o8y3Xu6hIR5M6BKzws4hyFzJ1WGcS64brqXyI4E5dfPNyOp
RTw7E67udpkxGhZL1NX+GUdtg6p6m2KVomSyxhB22QKBgQD8+16y5mQTqf5TiYu5
X0omJ4kWXprgfltx2aqby3JfzphA1N37aDBU8x/C8zJtqueprtMBQVblsnl2Ml6+
re+t8pFXWW/e2kXyGmPX3ujTDntltVUl1191+ucpwdFMAP/8bqTrzlytKsHSlTQI
4hHtZZkfMWjjxAeezSwKncYXKwKBgQDjybQZUhMYGskPalOXhqcCGlIyqUviANL6
oJpAJmwb6EJxrrY7nRTRbwNlfX6GzatS5shdFBR8XQhHKsE381jzGZK0qjx71bT+
kJooxO04L0KiNcbkbMHnIw1C+u0j5IdhlB4m0fAgx7Bjz6aqLGopGlmXKt7l1dIe
XHvbp7psSwKBgQD1hi0ZadrU7tYjU0nlJiM7toEo0bZ0jI3JiBw5yhD+BO7ldPLg
DfVibPd1aDyYDRd7Km4lOLnSgg259hbX7s3AP7xpTybw3VynJI+kMfY66EJAquWx
rT47rb/uWen8XrgS0XuEVCrD8cxcyWvP90C46zLaAEUxUM6og63ru8ZGMwKBgQCU
0A5PyHXe9ojKAF2yDW8ICagPntiLQpySzd9X74ILTVYzLL+y/HFATbU7VZwWd0Do
/QqC/H5RrPmefMkUQ2+mCdv1GY5AHKKM+G0uG1Eato1iqZ1RV9fpp9WfH41TOJZV
Yk28cMTetXaADoXEgRWt2qATCRfrsR//Y84q903sNwKBgChOam6KL/M8irtGndmi
lTdYERKfcFBKKPCCEaCQS4aNlfx4Kw3z7UMQbK/xV47w70dJOIxJZY32NGZJfTm/
6D/ckEoqLu7v3NeLkn+/GG65LMuGAyF8/uLFYGDdzTLF0AXPGCSKfRrYzWMTQHk4
nG3YoD4z4ACk0rDoWWF86EM5
-----END PRIVATE KEY-----
PEMEOF
drush php:eval '
  use Drupal\key\Entity\Key;
  $val = file_get_contents("/tmp/key_asymmetric_probe_priv.pem");
  if (!Key::load("ka_probe_priv")) {
    Key::create([
      "id"=>"ka_probe_priv","label"=>"KA Probe Private","key_type"=>"asymmetric_private",
      "key_type_settings"=>[],"key_provider"=>"config","key_provider_settings"=>["key_value"=>$val],
      "key_input"=>"textarea_field","key_input_settings"=>[],
    ])->save();
  }
' >/dev/null 2>&1
rm -f "$PEM"
drush cr >/dev/null 2>&1
echo "setup: key ka_probe_priv (asymmetric_private) created"
