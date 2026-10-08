<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring an SFTP Flysystem scheme

There is no admin UI. Define the scheme in `settings.php`:

```php
$schemes = [
  'sftpexample' => [
    'driver' => 'sftp',
    'config' => [
      'host' => 'example.com',
      'username' => 'username',
      'password' => 'password',      // OR use privateKey
      'privateKey' => '/path/to/or/contents/of/privatekey',
      'root' => '/path/to/root',
      // Optional
      'port' => 22,
      'timeout' => 10,
    ],
    'cache' => TRUE,
  ],
];
$settings['flysystem'] = $schemes;
```

`Drupal\flysystem_sftp\Flysystem\Sftp::getAdapter()` instantiates `League\Flysystem\Sftp\SftpAdapter($config)` and calls `connect()`. `ensure()` re-connects and reports login/root failures to the Flysystem status report.

## Hardening notes (from code review of `src/Flysystem/Sftp.php`)
- **Host-key verification is not enforced.** The module passes the raw config to `SftpAdapter` and never sets a fingerprint. The League v1 adapter supports a `hostFingerprint` config key — add it so the client rejects a changed/unknown host key (mitigates MITM). Without it the connection trusts any responding host.
- **Credential storage.** `password` / `privateKey` sit in plaintext in `$settings`. Keep `settings.php` out of VCS or load values from environment via a settings include; prefer key-based auth with a key file readable only by the web user.
