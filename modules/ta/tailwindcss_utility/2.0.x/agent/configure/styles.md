<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Tailwind styles

## Styles form — `/admin/appearance/tailwind` (perm `administer tailwindcss_utility`)
`Form/StylesForm` manages the utility-class configuration and triggers generation via `TailwindJsHandler`.

## Rule storage
`RuleStorageFactory` selects the backend implementing `TailwindRuleStorageInterface`:
- `TailwindRuleStorageConfig` — rules in config (exportable, deploy-friendly).
- `TailwindRuleStorageDatabase` — rules in the database (better for large/volatile sets).

## Delivery
`StackMiddleware/Tailwind` injects the compiled stylesheet into the response; `TailwindJsHandler` runs the Tailwind (JIT) generation for the collected classes.

## Layout Builder
`Form/LayoutFormsAlter` adds class inputs to LB section/block forms; `EventSubscriber/SectionSubscriberRenderArray` applies stored classes to section render arrays. Editors get class name help from the autocomplete route `/tailwind/class-autocomplete/{include_core}`.

## Permissions
- `administer tailwindcss_utility` — styles form + autocomplete.
- `access tailwindcss_utility endpoint` — the write API only; keep off untrusted roles.
