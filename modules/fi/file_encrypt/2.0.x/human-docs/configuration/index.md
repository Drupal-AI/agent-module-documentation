# Configuration

File encrypt does not have a single settings form. Instead you configure it in a
few places: one line in `settings.php`, a key and an encryption profile (provided
by the Key and Encrypt modules), and then a per-field choice of upload
destination. Work through the steps below in order.

## 1. Set where encrypted files are stored

In your site's `settings.php`, tell the module which directory should hold the
encrypted files:

```php
$settings['encrypted_file_path'] = 'sites/default/files-encrypted';
```

## 2. Create an encryption key

Create a key using your chosen encryption method — for example AES via the
**Real AES** module.

Storing the key securely is the whole point of the exercise, so use the **Key**
module to keep it out of the database. The recommended pattern on this project is
to put the secret in an environment variable and reference it through a Key
entity. For example, save the secret with DDEV's dotenv helper and then create an
environment-backed Key entity that reads it — that way the raw key never lives in
config or the database.

> **Key loss is data loss.** There is no recovery path for files encrypted with a
> key you can no longer produce. Design key backup and rotation *before* your first
> upload.

## 3. Create an encryption profile

Go to **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`) and add a profile that uses the
encryption method and the key you just created. This profile is what ties an
algorithm to a key.

## 4. Turn on encryption for a field

Encryption is enabled **per field**. On the field's **Field settings** page,
select **Encrypted files** as the upload destination. From then on, files
uploaded to that field are written through the `encrypt://` stream wrapper and
stored encrypted, then decrypted automatically when an authorised user downloads
them.

Internally the encrypted URLs take the form
`encrypt://{encryption_profile}/{path/to/file.ext}`, and the module exposes a
route that serves decrypted files according to the field's access rules, much like
private files.

## Webform uploads

For file uploads submitted through **Webform**, create an encryption profile
named `webform`, and File encrypt will use it for those uploads.

## Encrypting file metadata

File encrypt protects the file contents. To also encrypt metadata such as a
file's title or description, use the separate **Field Encryption** module.

## Two operational cautions

- **Image derivatives** are generated from decrypted content, so confirm for your
  setup whether the generated derivative is itself encrypted or is a plaintext
  copy sitting beside the encrypted original.
- **Encryption is not access control.** It protects the bytes at rest; deciding
  who may request a file remains the job of Drupal's normal file-access
  (`hook_file_download()`) machinery, just as with private files.
