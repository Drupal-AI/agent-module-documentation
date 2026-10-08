#!/usr/bin/env bash
# Execution RESET: ensure a private key ka_task_priv2 EXISTS (fixture), write a public-key PEM to
# /tmp/key_asymmetric_task_pub.pem, and ensure NO 'ka_task_pub' exists - so verify FAILS until the
# agent creates the public key and links it to ka_task_priv2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
cat > /tmp/key_asymmetric_task_priv2.pem <<'PEMEOF'
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
cat > /tmp/key_asymmetric_task_pub.pem <<'PEMEOF'
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4Ro4T8D/Dklowlmg29x5
F7AbGZKLW0vwj2WK5uz0KbsYXRRvhhrncQ7TI6alrP6icxg19exDJqcKpDcYq563
fGS7YLh4l9HOqnGjZ95+aW3Z+PVomneYNF0nLKKXgOVFeKpFyhOTeJJj3+Ie0xiS
3QvWknDcG3cCP5UWkElj1BQ1PgxNs1xEF9LjF5slbSP9aMch0Ppvvm3jUtCOi5Tb
12VopTcIyS18Z9srDIKmlHEgxaLzctMIBHKpZoKlfVSb48zxKhNNeTjYejhEI/QC
sxr2cFWBVyfdx2jdhNajCyz6yuANZ0veBXB3GCEnHQOEfhpJIPjHVxeEXrd+rQzt
mQIDAQAB
-----END PUBLIC KEY-----
PEMEOF
drush php:eval '
  use Drupal\key\Entity\Key;
  $priv = file_get_contents("/tmp/key_asymmetric_task_priv2.pem");
  if (!Key::load("ka_task_priv2")) {
    Key::create(["id"=>"ka_task_priv2","label"=>"KA Task Private 2","key_type"=>"asymmetric_private","key_type_settings"=>[],"key_provider"=>"config","key_provider_settings"=>["key_value"=>$priv],"key_input"=>"textarea_field"])->save();
  }
  if ($k=Key::load("ka_task_pub")) $k->delete();
' >/dev/null 2>&1
rm -f /tmp/key_asymmetric_task_priv2.pem
drush cr >/dev/null 2>&1
echo "reset: private ka_task_priv2 present, public PEM at /tmp/key_asymmetric_task_pub.pem, ka_task_pub absent"
