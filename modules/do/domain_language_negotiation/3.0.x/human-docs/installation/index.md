# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) enabled — this is what provides the
  detection-and-selection framework the method plugs into.
- **Domain** (`domain`) — the Domain Access module, which provides the domain
  records the language is read from.
- No separate PHP library requirements. From release 3.0.0 the former
  `domain_language` dependency is integrated into this module, so you no longer
  need to install it separately.

> **Release note:** the documented release is **3.0.0-alpha7** — an alpha. Test it
> thoroughly before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require "drupal/domain_language_negotiation:^3.0@alpha" -W
```

The `@alpha` stability flag is needed because the 3.x branch is at an alpha
release; the `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies, including the Domain module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require "drupal/domain_language_negotiation:^3.0@alpha" -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_language_negotiation -y
```

Make sure core's Language module and the Domain module are enabled and configured
first — you need multiple languages enabled and your domains created for the
detection method to have anything to resolve.

## Configure the detection method

Enabling the module makes a new detection method *available*, but it does nothing
until you turn it on and place it correctly in the detection order. See
[Configuration](../configuration/index.md) — the order is what makes or breaks it.

## Verify it worked

Set two domains to different languages on their domain records, then load each in a
browser. Each domain should serve its own language. If a domain serves the wrong
language, check the detection order first (this method must sit above session and
browser detection).
