<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Chat — settings form & configuration

Source: `src/Form/SettingsForm.php`, `ai_chat.routing.yml`, `ai_chat.links.menu.yml`,
`ai_chat.module`.

## Install / enable

`composer require drupal/ai_chat` then `drush en ai_chat`. Requires `ai_agents` (which provides
`ai_assistant_api`) and core `user`. Before the widget appears you must create at least one
**`ai_assistant`** entity in the AI Assistant API UI (`/admin/config/ai/ai-assistant`) and a working
AI provider; AI Chat only wires an existing assistant to roles.

## Settings form

- **Route**: `ai_chat.settings` → `/admin/config/ai/ai-chat`, permission
  **`administer site configuration`** (core). Menu link under `ai.admin_settings`
  (`ai_chat.links.menu.yml`).
- **Form id**: `ai_chat_settings_form`, extends `ConfigFormBase`.
- **Editable config**: `ai_chat.settings` (the only editable name).

`buildForm()` loads all `user_role` entities and all `ai_assistant` entities and renders:

- `chat_title` — textfield (maxlength 255). Empty → the widget falls back to `"AI Assistant"`.
- `appearance.primary_color` — `#type => color`, default `#0078d4` (`#tree => TRUE`, so it is
  submitted under `appearance[primary_color]`).
- `role_assistants[<rid>]` fieldset per role, each with:
  - `enabled` — checkbox (its state derives from whether the role already has assistants).
  - `assistant` — `#type => checkboxes` of assistant id → label; visible/required only when
    `enabled` is checked (via `#states`).
  - `default_assistant` — select of `'' (Default)` + assistant labels.

`submitForm()` saves `chat_title`, `primary_color` (only when non-empty), and rebuilds
`role_assistants`: for each role where `enabled` is set and at least one assistant is checked, it
stores `['assistants' => array_values(array_filter($checked)), 'default_assistant' => <id or ''>]`.
Roles with nothing enabled are omitted, so an empty `role_assistants` means "no chat anywhere".

## Config object `ai_chat.settings`

```yaml
chat_title: ''            # string; '' → widget shows "AI Assistant"
primary_color: '#0078d4'  # hex colour for the widget/toggle
role_assistants:          # keyed by role id
  authenticated:
    assistants: ['support_bot', 'faq_bot']   # assistant entity ids
    default_assistant: 'support_bot'         # '' allowed → first is used
```

There is **no `config/schema/`** in the module, so this object is schema-less (untyped). There is
also no `config/install/` default; the object comes into being on first save of the form.

## Who sees the widget (role → assistant resolution)

`ai_chat_page_attachments()` (hook_page_attachments) runs on every page:

1. Reads `role_assistants`; returns early if empty/non-array.
2. `_ai_chat_get_available_assistants($role_assistants, $account->getRoles(), $isAdmin)` unions the
   `assistants` arrays of the current user's roles. If the user has
   `administer site configuration`, it additionally unions **every** role's assistants (admins see
   all configured assistants).
3. `_ai_chat_get_default_assistant(...)` returns the first role's `default_assistant`; falls back to
   the first available assistant if the default is missing or not in the available set.
4. If no assistant is available, nothing is attached (no widget). Otherwise it attaches library
   `ai_chat/widget` and `drupalSettings.ai_chat` = `{ endpoint, assistants (id→label), defaultAssistant,
   primaryColor, title }`.

So visibility is entirely a function of the role→assistant mapping — the module defines **no
permission of its own**. Mapping an assistant to the `authenticated user` (or `anonymous user`) role
makes the widget appear for those users.
