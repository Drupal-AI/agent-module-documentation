# Go-wkhtmltoX Client — manual setup guide

**Go-wkhtmltoX Client** (`go_wkhtmltox`) connects Drupal to a
**[Go-WkhtmltoX](https://github.com/gogap/go-wkhtmltox)** service — a Go-based
wrapper around `wkhtmltopdf`/`wkhtmltoimage` that renders HTML into **PDFs and
images**. Instead of running the conversion binaries on your web server, Drupal
sends the HTML to a remote Go-WkhtmltoX endpoint and gets the finished PDF or image
back, which scales better for high-throughput document generation.

It is a developer-oriented integration. The module gives you a client service and a
small API — converters (`ToPdfConverter`, `ToImageConverter`) and a data fetcher —
that other code calls to turn a rendered Drupal render array into a PDF or image.
There is no editor-facing UI; you use it from custom module code.

The one thing you must set up is the **endpoint** — the URL of your Go-WkhtmltoX
service. Because the module hands your HTML to that service over the network, keep
the endpoint on a **trusted network** and store any credentials it needs securely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin settings form**. The endpoint is configured in `settings.php`,
and everything else happens in code — both covered below.

## Configure the endpoint

Add your Go-WkhtmltoX service URL to your site's `settings.php` (or a
`settings.local.php` that is not committed):

```php
$config['go_wkhtmltox.settings']['endpoint'] = 'http://wkhtmltox:8080';
```

Point it at wherever your Go-WkhtmltoX service runs. Keep that service reachable
only from your application (a private/trusted network), since it will render
whatever HTML Drupal sends it.

## How to use it (in code)

Once the endpoint is set, convert a render array to a PDF from custom code:

```php
use Drupal\go_wkhtmltox\API\Converter\ToPdfConverter;
use Drupal\go_wkhtmltox\API\Fetcher\DataFetcher;

$build = ['#type' => 'inline_template', '#template' => 'Hello world!'];
$html = (string) \Drupal::service('renderer')->renderPlain($build);

$converter = new ToPdfConverter();
$converter->setOption('extend', [
  'dpi' => '300',
  'page-width' => '210mm',
  'page-height' => '297mm',
]);

$fetcher = new DataFetcher();
$fetcher->setParam('data', $html);

$pdf_file = \Drupal::service('go_wkhtmltox.client')->convert($converter, $fetcher);
```

Swap `ToPdfConverter` for `ToImageConverter` (and set an image `format` such as
`png`) to produce an image instead.
