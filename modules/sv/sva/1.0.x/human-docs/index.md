# Simple Views Accordion — manual setup guide

**Simple Views Accordion** (`simple_views_accordion`) adds a Views display **style**
that renders your View's results as an accordion — a stack of collapsible sections,
where each row becomes a header you click to expand and reveal its content.

It is a lightweight way to present content compactly and let visitors open only the
item they care about. FAQs are the classic case — question in the header, answer in
the expandable body — but it works well for any list whose rows read naturally as
expand/collapse sections: feature lists, grouped content, documentation snippets.
Under the hood it leans on the standard `details` render element, so the collapsing
behaviour is native and dependency-light. It depends only on core **Views**.

This is purely a presentation style: it changes how the View's results are rendered,
not which results appear or who may see them. The View's own access controls still
govern what shows up, so the accordion has no effect on access. There is no settings
page — you turn it on and configure it inside the View itself.

> **A note on names.** This project's machine name is `simple_views_accordion`
> (that is the name you enable with Drush and see in the UI), but its Composer
> package is **`drupal/sva`**. Use `drupal/sva` in the `composer require` command and
> `simple_views_accordion` in the `drush en` command.

This guide is written for a **human** setting the style up in the Views UI. If you
are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Edit (or create) a View at **Structure → Views**.
2. In the **Format** section, change the display format to **Simple Views
   Accordion**.
3. Configure the style settings to map which field acts as each row's **header**
   (the always-visible label) and which field provides the **content** that expands
   below it.
4. Save the View.

When the View renders, each result becomes a collapsible section: visitors see the
headers and click to expand the row they want.
