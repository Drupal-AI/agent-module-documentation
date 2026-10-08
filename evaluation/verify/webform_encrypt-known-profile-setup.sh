#!/usr/bin/env bash
# Introspection SETUP: webform we_encrypt_profile with element 'card' encrypted using
# encryption profile we_test_profile, so an agent can report the profile in use. Exit 0.
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
  $elements = "card:\n  \x27#type\x27: textfield\n  \x27#title\x27: Card\n";
  $w = Webform::load("we_encrypt_profile");
  if (!$w) { $w = Webform::create(["id" => "we_encrypt_profile", "title" => "WE Encrypt Profile"]); }
  $w->set("elements", $elements);
  $w->setThirdPartySetting("webform_encrypt", "element", [
    "card" => ["encrypt" => TRUE, "encrypt_profile" => "we_test_profile"],
  ]);
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform we_encrypt_profile element card encrypted with profile we_test_profile"
