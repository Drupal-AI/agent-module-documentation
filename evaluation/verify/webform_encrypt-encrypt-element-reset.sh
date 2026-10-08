#!/usr/bin/env bash
# Execution RESET: ensure webform we_encrypt_task exists with elements name+ssn and NO
# webform_encrypt encryption set (verify FAILS until agent encrypts ssn). Also ensure the
# encryption profile we_test_profile exists to select. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  use Drupal\encrypt\Entity\EncryptionProfile;
  use Drupal\webform\Entity\Webform;
  try {
    if (!Key::load("we_test_key")) {
      Key::create([
        "id" => "we_test_key", "label" => "WE Test Key",
        "key_type" => "encryption", "key_type_settings" => ["key_size" => "128"],
        "key_provider" => "config",
        "key_provider_settings" => ["key_value" => "abcdef0123456789", "base64_encoded" => FALSE],
      ])->save();
    }
    if (!EncryptionProfile::load("we_test_profile")) {
      EncryptionProfile::create([
        "id" => "we_test_profile", "label" => "WE Test Profile",
        "encryption_method" => "mcrypt_aes_128",
        "encryption_method_configuration" => [], "encryption_key" => "we_test_key",
      ])->save();
    }
  } catch (\Throwable $e) {}
  $elements = "name:\n  \x27#type\x27: textfield\n  \x27#title\x27: Name\nssn:\n  \x27#type\x27: textfield\n  \x27#title\x27: SSN\n";
  $w = Webform::load("we_encrypt_task");
  if (!$w) { $w = Webform::create(["id" => "we_encrypt_task", "title" => "WE Encrypt Task"]); }
  $w->set("elements", $elements);
  $w->unsetThirdPartySetting("webform_encrypt", "element");
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform we_encrypt_task present, no encryption; profile we_test_profile available"
