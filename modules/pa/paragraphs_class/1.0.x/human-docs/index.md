# Paragraphs Class — manual setup guide

**Paragraphs Class** (`paragraphs_class`) adds a Paragraphs *behavior plugin* that lets
content editors type a custom CSS class into an individual paragraph. At render time the
module adds that class to the paragraph's wrapper element, so editors can restyle a single
paragraph — a spacing utility, a background modifier, a design-system component class, or a
hook for JavaScript — without anyone touching a template.

It is deliberately tiny. There is one behavior ("Paragraphs wrapper class") that can be
turned on for any Paragraphs type. Once enabled, a "Wrapper class" text field appears on
that paragraph in the content form; whatever you type is added to the class attribute on
output. The field is free text with a single input, so you supply valid, space-separated
class names yourself. Drupal escapes class values on render, so it is a styling hook only —
not a place raw HTML can be injected.

There is no settings page, no permission of its own (editing the field uses Paragraphs'
standard behavior-settings permission), and no Drush commands. It depends only on the
contrib **Paragraphs** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## How to use it

There is no configuration page — the module works entirely through the Paragraphs behavior
system.

**1. Turn the behavior on for a Paragraphs type.** Go to **Structure → Paragraphs types**,
edit the type you want, open the **Behaviors** tab, tick **"Paragraphs wrapper class"**, and
save. Because the behavior applies to every Paragraphs type, you can enable it selectively —
only on the types that need per-instance styling. (You need the core "edit behavior plugin
settings" permission to see the Behaviors tab.)

**2. Set a class on a paragraph.** When editing content, each paragraph of that type now
shows a **"Wrapper class"** text field in its behaviors area. Type one or more space-
separated class names, for example `mb-4 bg-light`.

**3. What renders.** The value is added to the paragraph's outer wrapper element in the
rendered HTML, so your theme's (or a CSS framework's) styles for those classes take effect.

There is no validation or whitelist and no separate "multiple classes" widget — just type
the classes you want, separated by spaces, and make sure they are valid CSS class names.
