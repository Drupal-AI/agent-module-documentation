# Views Contextual Filter Validator: Number Range — manual setup guide

**Views Contextual Filter Validator: Number Range**
(`contextual_filter_range_validator`) adds one new **argument validator** to
Views' contextual filters. With it, a View's contextual‑filter argument is
accepted only when it is a number that falls within a minimum/maximum range you
configure; values outside that range fail validation, and you choose what happens
when they do (hide the view, show a summary, and so on).

The most common trick this enables is showing or hiding part of a view based on a
URL parameter. For example, you can make a view attachment appear only on the
first page of a pager: validate the `page` query parameter against a range whose
maximum is `0`, so any page beyond the first fails validation and the attachment
is hidden. It depends only on core **Views**.

Keep in mind this is a **validation** feature, not access control: it constrains
what argument values a view will accept, it does not protect data or restrict who
can see it. It has no settings page of its own — everything is configured on the
contextual filter inside the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You select the validator on a
view's contextual filter, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely inside the Views UI at
**Structure → Views** (`/admin/structure/views`), on a display's contextual
filter settings.

## How to use it

The example below shows an attachment only on the first page of a paged view:

1. Create a **page** view with an **attachment** display.
2. On the attachment, add a contextual filter: **Advanced → Contextual Filters →
   Add**. In the "Add contextual filters" popup, choose **This attachment
   (override)** from the *For* menu, choose **Global** from the category menu,
   tick the **Null** filter, and click **Apply (this display)**.
3. Under **When the filter value is NOT available**, choose **Provide a default
   value** and set *Type* to **Query parameter**, *Query parameter* to `page`, and
   *Fallback value* to `0`.
4. Under **When the filter value IS available or a default is provided**, choose
   **Specify validation criteria**, set *Validator* to **Range**, leave *Minimum
   value* blank, set *Maximum value* to `0`, and set *Action to take if filter
   value does not validate* to **Hide view**.
5. Click **Apply (this display)**, then **Save** the view.

The attachment now shows only on the first page, because any non‑zero `page`
parameter falls outside the `0` maximum and hides it.
