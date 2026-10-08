# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **LMS** module (`lms`) — LMS Certificate extends it.
- The **Dynamic Entity Reference** module (`dynamic_entity_reference`) — used so a
  certificate of any entity type can be referenced from a course.
- For PDF certificates: the **FillPDF** module, with its PDF-generation service
  configured (see below).

This is a **1.0.0-alpha3** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_certificate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
LMS and Dynamic Entity Reference dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_certificate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_certificate -y
```

## Submodule — PDF certificates

To generate PDF certificates, also enable the bundled submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **LMS Certificate FillPDF** | `lms_certificate_fillpdf` | Lets you upload a fillable PDF form and map its fields to tokens, producing a filled-in PDF certificate on course completion. Requires the FillPDF module and a working FillPDF service. |

```bash
drush en lms_certificate_fillpdf -y
```

## Configure FillPDF before using PDF certificates

FillPDF needs a PDF-generation backend (service) configured before it can fill and
produce PDFs. Follow the FillPDF module's own setup to install and configure that
service successfully — until this works, certificates will not be generated.

## Verify it worked

With LMS, LMS Certificate, the FillPDF submodule, and a working FillPDF service in
place, associate a certificate with a course, complete that course as a test
learner, and confirm the learner can view/download their generated certificate.
See [How to use it](../index.md#how-to-use-it) for the full flow.
