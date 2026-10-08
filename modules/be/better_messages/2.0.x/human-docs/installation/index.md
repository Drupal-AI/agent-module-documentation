# Installation

## Requirements

Better Messages needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI Draggable** (`jquery_ui_draggable`) and **jQuery UI Resizable**
  (`jquery_ui_resizable`) modules — these power the drag and resize features.
  They are declared as dependencies, so Drupal enables them automatically when you
  turn on Better Messages, and Composer downloads them for you.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/better_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it also brings in the two jQuery UI modules Better
Messages relies on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_messages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_messages -y
```

Drupal enables `jquery_ui_draggable` and `jquery_ui_resizable` at the same time as
dependencies. As soon as the module is on, your status messages are restyled as
popups using the shipped defaults — you do not have to configure anything to see
the effect.

## Submodules

Better Messages ships no submodules — the base module is everything.

## Verify it worked

Do something that produces a Drupal message, such as saving a node or clearing a
form. Instead of the usual flat message strip, you should see an animated popup
(by default centered, fading in and out). From there, head to
[Configuration](../configuration/index.md) to change the position, timing, and
behavior.
