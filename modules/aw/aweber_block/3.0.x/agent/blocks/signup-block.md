<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Signup block & form

## Block plugin `aweber_block`

`src/Plugin/Block/AweberBlock.php` — annotation `@Block(id = "aweber_block", admin_label = "Aweber block")`, implements `ContainerFactoryPluginInterface`. Injected: `aweber_block.manager` (`AweberServiceInterface`), `form_builder`, `config.factory`.

- **Constructor** immediately calls `AweberManager::accounts()`. If any account is returned it takes the first account's `id`, fetches that account's lists via `AweberManager::lists()` into `$listOptions`, and persists `aweber_account_id` back into `aweber_block.aweberblockconfig`. (So merely placing/rendering the block writes config and makes live AWeber API calls — the connection must already be authorized.)
- **`blockForm()`** — adds an `email_lists` checkboxes element whose `#options` are the account's AWeber lists (`$listOptions`); the site builder selects which lists this block instance offers. Saved by `blockSubmit()` into block config keys `aweber_block_email_selected_lists` (raw checkbox values) and `aweber_block_email_lists` (id→name map of the chosen lists).
- **`build()`** — constructs an `AweberForm` seeded with the configured `aweber_block_email_lists`, the config object, messenger, and the manager service, and returns it via `form_builder->getForm()`.

## Public form `AweberForm` (`aweber_block_form`)

`src/Form/AweberForm.php` extends core `FormBase` (a standard Drupal Form API form). Constructed with `($fields, $aweberConfig, $messenger, $aweberService)` where `$fields` is the block-configured id→name list map, and reads `enable_redirect` / `redirect_link` from config into `$redirectParams`.

- **`buildForm()`** renders:
  - `email` — `#type => email`, required.
  - `email_lists` — `#type => checkboxes`, required, `#options => $this->fields` (only the lists the block was configured to offer).
  - a `Register` submit button.
- **`submitForm()`** iterates the selected list ids; for each chosen list it builds `$params['email'] = $email`, calls `AweberManager::checkSubscriberExistsByEmail($email, $listId)`, and only if that returns TRUE calls `AweberManager::addSubscribers($listId, $params)`. If `enable_redirect` is set, it redirects to `Url::fromUri($redirect_link)` after submission.

Note on `checkSubscriberExistsByEmail`: it returns TRUE when the AWeber "find" query returns **no** entries (i.e. the email is *not* yet on the list) and FALSE when it already exists — so a new email is added and an existing one is skipped (avoids duplicate subscribe calls).

## Thank-you output

`aweber_block_redirect.default` (`/aweber_block/thankyou`) → `AweberBlockController::index()` returns `['#theme' => 'aweber_block']`, rendered by `templates/aweber-block.html.twig` ("Thank you for registering!!"). Override the `aweber_block` theme hook (declared in `aweber_block_theme()`) to customize.

## Placing the block

Enable the module, complete the OAuth authorization (see `../config/settings.md`), then place "Aweber block" via Block Layout (`/admin/structure/block`) and tick the lists to offer. Visitors then see the email + list-choice form.
