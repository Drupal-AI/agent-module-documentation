# Enum Generator — manual setup guide

**Enum Generator** (`enum_generator`) is a developer tool that turns a Drupal
**taxonomy vocabulary's terms** into a ready‑to‑use PHP file — either a PHP 8.1
`enum` or a class of constants — so your code can reference term IDs by meaningful
names instead of magic numbers. It builds the file with the
`nette/php-generator` library and hands it back to you as a browser download.

At initial release it supports taxonomy vocabularies and terms (the maintainer
hopes to extend it to other entity types later). For a vocabulary called
"Animals" with terms Cat, Dog, and Fish, it produces something like:

```php
namespace Drupal\my_module\Enum;

enum AnimalsTerm: int
{
    /** Represents the "Cat" term. */
    case CAT = 37;
    /** Represents the "Dog" term. */
    case DOG = 36;
    /** Represents the "Fish" term. */
    case FISH = 35;
}
```

The generated file is a **developer artifact you drop into a module** — nothing on
the running site is changed, installed, or configured. Regenerate whenever you add
or rename terms. (Because the file comes from `nette/php-generator`, it does not
strictly follow Drupal coding‑style conventions yet.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no persistent settings form** for this module — the generator form
produces a one‑off download rather than saving configuration, so it is described
in "How to use it" below.

## Where it lives in the admin menu

Enum Generator adds a generator page under **Structure → Enum Generator**
(`/admin/structure/enum-generator`), with the taxonomy generator at
`/admin/structure/enum-generator/taxonomy`. Access is gated by the **Access enum
generator** permission (marked *restrict access* — grant it only to trusted
developers).

## How to use it

1. Grant the **Access enum generator** permission to the developer role that
   should use the tool.
2. Go to **Structure → Enum Generator → Taxonomy**
   (`/admin/structure/enum-generator/taxonomy`).
3. Fill in the form:
   - **Namespace** — the target namespace for the generated file (for example
     `Drupal\my_module\Enum`). It must **not** start with a backslash; the form
     validates this.
   - **Vocabulary** — the taxonomy vocabulary whose terms become the cases or
     constants.
   - **Generation Type** — choose **enum** (a PHP 8.1 enum) or **const** (a class
     of constants), depending on your PHP version and preference.
   - **Backing Type** — choose **string** (the default; Drupal term IDs are
     strings) or **int** (IDs cast to integers).
4. Submit. The module loads the vocabulary's terms (sorted by label), turns each
   term label into an `UPPER_SNAKE_CASE` name — prefixing an underscore if the
   label starts with a digit — sets the term ID as the value, adds a doc comment
   per case, and streams the finished `.php` file back to your browser as a
   download.
5. Drop the downloaded file into a custom module and use it in your code.
   Reload the page to generate another file for a different vocabulary.
