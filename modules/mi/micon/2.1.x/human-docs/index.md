# Micon — manual setup guide

**Micon** (`micon`) is an IcoMoon-based icon manager for Drupal. You upload icon
packages — IcoMoon font or SVG exports downloaded as `.zip` files — as manageable
**Micon package** entities, and then reference any icon by a short ID (for example
`fa-user`) throughout your site: from a Twig function, a render element, a form
element, an icon field on your content, or a small PHP API. There's no manual CSS
wiring — activating a package makes its stylesheet load site-wide automatically.

Icons are addressed by a **selector** made of the package's prefix plus the icon
name. The module ships one package out of the box, **Font Awesome** (prefix `fa`),
so `fa-user`, `fa-star`, `fa-trash`, and the rest work immediately. Uploading your
own IcoMoon export gives you a new prefix and its icons. You can add an **"Icon"
field** to any content type so editors pick an icon per item, expose a searchable
icon picker in a form, or auto-decorate certain text strings with icons via a YAML
mapping.

Micon has no third-party dependencies and adds an *Administer micon* permission
and a Drush command (to export active icons as an SCSS mixin). It also ships
**nine submodules** that put icons in specific places: content types, vocabularies,
paragraph types, menu links, link fields, Linkit widgets, admin local-task tabs,
and CKEditor. Some of those need other contrib modules (Paragraphs, Linkit, Link
Attributes) — see Installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — upload icon packages and add an icon
   field.

## Where it lives in the admin menu

The icon-package manager is at **Structure → Micon**
(`/admin/structure/micon`).

## How to use it

Once a package is active, developers and site builders can render its icons in
several ways (full details are in the [`agent/`](../agent/start.md) docs):

- In a Twig template: `{{ micon('fa-user') }}`.
- In a render array: `['#theme' => 'micon_icon', '#icon' => 'fa-star']`, or with a
  label: `['#theme' => 'micon', '#icon' => 'fa-user', '#title' => t('Profile'),
  '#position' => 'after']`.
- On content: add an **"Icon"** field (see
  [Configuration](configuration/index.md)) so editors choose an icon per node,
  term, paragraph, and so on.
- In a form: a searchable icon-picker element (`'#type' => 'micon'`).

For everyday content editing, the icon field and the submodules (icons on menu
links, content types, etc.) are the main touch points.
