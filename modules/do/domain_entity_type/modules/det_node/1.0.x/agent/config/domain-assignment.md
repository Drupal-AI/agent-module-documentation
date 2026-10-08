<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assigning a content type to domains

## Where the setting lives

There is no dedicated settings form. The assignment is made on the standard **content type**
add/edit form and stored as a **third-party setting** on the `node_type` config entity:

- namespace: `det_node`
- key: `domains`
- value: array of enabled **domain machine ids**; empty array = available on **all** domains.

Read/write in code with the core config-entity API:

```php
$domains = $node_type->getThirdPartySetting('det_node', 'domains', []);
$node_type->setThirdPartySetting('det_node', 'domains', ['domain_a', 'domain_b']);
```

Because it is config, assignments export/import with `drush config:export` / `config:import`
(exported under `node.type.<type>` third-party settings). Note the module ships **no config
schema** for the setting, so strict schema tooling may warn.

## The form alter (`det_node.module`)

`det_node_form_alter(&$form, $form_state, $form_id)` acts only on `node_type_add_form` and
`node_type_edit_form`. It:

1. Loads enabled domains: `entityTypeManager()->getStorage('domain')->loadByProperties(['status' => 1])`.
2. Builds `#options` from each domain's `label()`.
3. Adds a `#type => 'details'` group `det_node` titled *"Domain access"* in the
   `additional_settings` group (the vertical-tabs area of the content-type form).
4. Adds a `#type => 'checkboxes'` element `domains` with `#default_value` =
   `$entity->getThirdPartySetting('det_node', 'domains', [])`, described as
   *"Select the affiliate domain(s). If nothing was selected: Affiliated to all domains."*
5. Registers `det_node_content_type_builder` in `$form['#entity_builders']`.

`det_node_content_type_builder($entity_type, NodeTypeInterface $entity, &$form, $form_state)` runs
on submit and stores `array_filter($form_state->getValue('domains'))` (dropping unchecked/`0`
values) back into the `det_node`/`domains` third-party setting.

## UI path

`/admin/structure/types/manage/<type>` → open the **Domain access** tab → tick the domains that
may use this content type → **Save**. Leave everything unticked to keep it on all domains.

## What consumes it

Every enforcement layer reads the same `det_node`/`domains` setting and compares it against the
active domain from `domain.negotiator`. See [../access/enforcement.md](../access/enforcement.md).
