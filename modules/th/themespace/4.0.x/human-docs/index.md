# Themespace — manual setup guide

**Themespace** (`themespace`) is a developer utility, not an end-user feature. It
adds the namespaces of your enabled themes to the dependency-injection container
(as the `containers.themespaces` parameter) and provides a `themespace.namespaces`
service, so that plugin managers can discover class-based plugins that live inside
*themes* — not just modules. In short, it lets themes use the same object-oriented,
attribute-based plugin patterns that modules already enjoy.

On top of that, it provides "provider-typed" plugin definitions and attributes.
These let a plugin manager tell theme-provided plugins apart from module-provided
ones and handle them separately — which matters because a theme's plugins should
generally only apply when that theme (or one of its base themes) is the active
theme. The module ships as a demonstration of exactly that pattern.

Themespace **adds no functionality on its own**. Enabling it does nothing visible;
its whole purpose is to give module and theme developers the building blocks to
create new plugin APIs that support theme-based discovery. Other projects depend on
it — for example **Transmuter**, which uses it to make theme preprocessors
discoverable as plugins. If you are installing Themespace, it is almost always
because another module requires it, or because you are building something that does.
It has no configuration, and supports Drupal 11 and 12.

> **Upgrading note.** Version 3 corrected the theme-namespace naming convention. Use
> `\Drupal\<theme>\…` (matching Drupal's module/theme convention) rather than the
> older `\Drupal\Theme\<theme>\…`, and replace `container.namespaces` with the
> `themespace.namespaces` service for your plugin manager's namespace traversable.
> If you followed the previously suggested convention, this is a breaking change to
> be aware of. See the module's README for the full "Provider Typed Plugins" details.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (usually as a dependency of another module).

## How to use it

There is no admin screen. You use Themespace from code: register your theme's PHP
class namespace, and point your plugin manager's namespace traversable at the
`themespace.namespaces` service so it can discover attribute-based plugins inside
enabled themes. The README's "Provider Typed Plugins" section walks through the
definition and discovery classes.
