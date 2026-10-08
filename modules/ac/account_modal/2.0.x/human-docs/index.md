# Account Modal — manual setup guide

**Account Modal** (`account_modal`) makes account-related links — login, register,
and password reset — open in a modal dialog instead of navigating to a separate
page. A visitor who clicks "Log in" stays where they are and gets the form in an
overlay, which keeps the flow in-context and feels smoother than a full page load.

It is purely a presentation change. The underlying login, registration and
password-reset forms are the same core forms, and they still enforce Drupal's
normal authentication and access rules — the modal is only how they are displayed.
The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which account links open in a
   modal.

## Where it lives in the admin menu

Account Modal has a settings form (`account_modal.admin_settings`) where you choose
which account links open as modals. See [Configuration](configuration/index.md).
