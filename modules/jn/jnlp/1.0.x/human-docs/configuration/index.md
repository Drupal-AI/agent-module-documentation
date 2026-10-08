# Configuration

How much configuration JNLP needs depends on which analyzer you enabled. The
pure‑PHP analyzers work with no configuration; the MeCab and Sudachi analyzers need
you to tell Drupal where their binaries live.

## Analyzer paths go in `settings.php` (MeCab and Sudachi)

For security, the paths to external analyzer binaries are **not editable in the
UI** — you set them in your site's `settings.php`. For example, for Sudachi:

```php
$settings['jnlp_sudachi_jar_path'] = '/opt/sudachi/sudachi-0.7.5.jar';
```

Set the equivalent path settings for MeCab if you use that analyzer. **Igo‑php** and
**TinySegmenter** are pure PHP and need no path configuration at all.

## Sudachi split mode

If you use Sudachi, you can choose its **split mode (A, B, or C)** — which controls
how finely text is segmented — at **Configuration → Region and language → Japanese
Natural Language Processing → Sudachi** (`/admin/config/regional/jnlp/sudachi`).

## Verify with the test forms

Each analyzer has an **admin test form** at **Configuration → Region and language →
Japanese Natural Language Processing** (`/admin/config/regional/jnlp`). Enter
Japanese text and inspect the tokens the analyzer produces — this is the quickest
way to confirm that a MeCab or Sudachi path is correct and that everything is wired
up before another module starts relying on the service.

## Permissions

Access to these administration and test pages is controlled by the **Administer
Japanese Natural Language Processing** permission (**People → Permissions**). It's a
restricted‑access permission, so grant it only to trusted administrators.

## For developers

Consuming modules call the `process($text)` service method and can check
availability first with `isExecutable()` / `isAvailable()`, so they can degrade
gracefully when a given analyzer isn't installed. The module README (English and
Japanese) documents the developer API and stability policy in full.
