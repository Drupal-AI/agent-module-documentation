<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Renderable is a small Twig extension whose headline feature is `will_have_output()`, a function that tells a template whether a render array would actually produce visible output — so you can hide an empty wrapper — plus two filters, `add_class` and `merge_attributes`, that decorate render arrays or `Attribute` objects from inside Twig.

---

The recurring problem in Drupal templates is the empty wrapper: you print `{{ content.field_foo }}` inside a `<div class="card">`, the field turns out to be empty, and you are left with an empty styled box, a stray heading, or a border around nothing. You cannot reliably test a render array for emptiness in Twig, because a render array is a nested structure whose "emptiness" is only known after it is rendered — access checks, `#access`, lazy builders and formatters all run at render time. This module's `will_have_output('content', 'field_foo')` resolves that: given a variable name and an optional path of nested keys (it is variadic, `needs_context` and `needs_environment`), it walks the template context with `NestedArray::getValue`, renders the element through the real renderer, **replaces the element in context with the already-rendered `#markup`** so the work is not repeated when you print it, strips HTML comments when Twig debug is on, and returns a boolean of whether the trimmed output is non-empty. The two filters are ordinary Twig filters: `add_class(class)` appends a class to a render array's `#attributes.class` or calls `->addClass()` on an `Attribute`; `merge_attributes(attributes)` merges an attributes array (or `Attribute`) into either a render array's `#attributes` or an `Attribute` object. Version **8.x-1.5**, core `^8`–`^11`, no dependencies, no configuration, no permissions, no schema — one service tagged `twig.extension`. Note that none of the callbacks set an `is_safe` flag, so nothing new is marked printable-without-escaping; output already carried its own safety from the renderer, and the filters return renderables/attributes that Twig escapes as usual. The one behavioural subtlety to remember: because `will_have_output` mutates the context entry into `#markup`, testing a variable also finalises it.

---

- Test whether a field's render array will produce output before printing its wrapper: `{% if will_have_output('content', 'field_foo') %}`.
- Suppress an empty `<div>`/`<section>` wrapper around a conditionally-empty field.
- Hide a heading and its region when the region below it renders empty.
- Check a nested render-array path such as `will_have_output('content', 'field_media', 0)`.
- Test a top-level variable (no parents) for non-empty rendered output.
- Avoid duplicate rendering: the function caches the rendered result back into context so the later `{{ ... }}` reuses it.
- Decide whether to output a separator/comma between two possibly-empty pieces.
- Gate a "Read more" link on whether a summary actually rendered.
- Add a CSS class to a render array from Twig: `{{ content.field_x|add_class('highlight') }}`.
- Add a class to an `Attribute` object: `{{ attributes|add_class('is-active') }}`.
- Merge an attributes array into a render array: `{{ element|merge_attributes({'data-foo': 'bar'}) }}`.
- Merge one `Attribute` object into another element's attributes.
- Attach `data-*` attributes to a rendered element without a preprocess function.
- Compose a class list conditionally in the template layer.
- Keep an empty region out of the DOM to let CSS `:empty` or grid gap rules behave.
- Clean up field templates that would otherwise emit blank markup.
- Reduce one-line preprocess functions whose only job was an emptiness check.
- Wrap `will_have_output` around lazy-builder / `#access`-gated content whose emptiness is only known at render time.
- Build accessible markup that omits labels for regions that render nothing.
- Prototype template conditionals quickly without editing PHP.
- Add classes to view or entity render arrays passed into a template.
- Combine `add_class` and `merge_attributes` in a filter chain on one element.
- Avoid printing an ARIA landmark for an empty content area.
- Conditionally render a card component only when its body has content.
