#!/usr/bin/env bash
# Execution RESET: webform we_encrypt_task2 with element 'notes', no encryption. Ensures
# profile we_test_profile exists. verify FAILS until agent encrypts notes with that profile.
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
  $elements = "notes:\n  \x27#type\x27: textarea\n  \x27#title\x27: Notes\n";
  $w = Webform::load("we_encrypt_task2");
  if (!$w) { $w = Webform::create(["id" => "we_encrypt_task2", "title" => "WE Encrypt Task 2"]); }
  $w->set("elements", $elements);
  $w->unsetThirdPartySetting("webform_encrypt", "element");
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform we_encrypt_task2 present, no encryption; profile we_test_profile available"
