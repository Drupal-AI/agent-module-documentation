# Form Factory Kits — manual setup guide

**Form Factory Kits** (`formfactorykits`) provides object‑oriented "kits" —
reusable builder components for constructing arrays that are compatible with the
Drupal Form API. Used together with **Form Factory**, kits let you assemble a form
from composable, chainable pieces instead of writing nested render arrays by hand.
Its tagline is simply: *make custom Drupal forms… faster.*

Each kit generates a Render‑API‑compatible array, and when appended to a Form
Factory instance it helps build a complete form. The kits shipped here cover the
Form API basics (text fields, textareas, checkboxes, images, submit buttons,
vertical tabs, and so on), and any module can provide its own collections of kit
objects. A representative snippet:

```php
public function buildFormObject(FormFactoryInterface $form_factory, FormFactoryKitsInterface $kits): void {
  $tabs = $kits->verticalTabs();
  $form_factory->append($tabs);

  $dogsTab = $tabs->createTab('dogs')->setTitle($this->t('Dogs'));
  $dogsTab->append($kits->image('dogs_image')->setTitle($this->t('Image')));
  $dogsTab->append($kits->textarea('dogs_description')->setTitle($this->t('Description')));

  $form_factory->append($kits->submit());
}
```

This is a **developer library** — there is no admin UI, no settings page, and it
has no content or access role of its own. You use it from PHP code, alongside the
Form Factory module and the underlying Kits library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on Kits and Form Factory).

There is **no configuration page** — this is a code‑only developer library. Once
enabled, the kit factory service is available to your custom modules.

## How to use it

Enable the module (along with Form Factory), inject the `FormFactoryKits` service,
and call its kit methods — `text()`, `textarea()`, `checkboxes()`, `image()`,
`verticalTabs()`, `submit()`, and so on — appending the resulting kits to a Form
Factory instance to build up your form (as shown above).
