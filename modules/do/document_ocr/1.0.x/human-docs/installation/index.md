# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The external engine or service you intend to use — for example a **Google Cloud /
  Document AI** account and credentials, or a local **Tesseract** / **Poppler
  (pdftotext)** / **docconv** installation, or an **OpenAI** key. Which one you need
  depends on the processor you configure; see the module's `README.md` for
  engine-specific setup.
- Any required PHP libraries are installed by Composer when you require the module.

## Install with Composer

From the project root:

```bash
composer require 'drupal/document_ocr:^1.0' -W
```

Using Composer is important — it installs all the required dependencies. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require 'drupal/document_ocr:^1.0' -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en document_ocr -y
```

## Add a provider (optional)

To use Mindee or AI21 Studio as an OCR/transformer provider, install the matching
companion module and see its own guide:

```bash
composer require drupal/document_ocr_mindee -W   # Mindee
composer require drupal/document_ocr_ai21 -W     # AI21 Studio
```

## Verify it worked

Visit **Configuration → Structure → Document OCR**
(`/admin/config/structure/document-ocr`). You should see the mappings listing and be
able to add a document processor. From there, continue to
[Configuration](../configuration/index.md) to wire up a processor, a mapping, and its
credentials.
