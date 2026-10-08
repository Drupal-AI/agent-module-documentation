# Accessible Form Validation — manual setup guide

**Accessible Form Validation** (`accessible_form_validation`) improves how Drupal
reports form errors to assistive technology. Out of the box, Drupal prints
validation errors in a message region at the top of the page and adds an `.error`
class to the offending fields — fine for a sighted user who scrolls up, much weaker
for anyone using a screen reader. This module aims to close that gap so that people
who cannot see the error can still complete the form.

Form validation is where accessibility most often fails, and the consequences are
severe: a user who cannot perceive an error cannot register, cannot pay, and cannot
get in touch. Doing it properly means associating each failing field with its
message (so the message is read when focus reaches the field, not only at the top of
the page), announcing the error summary when it appears, moving focus to the first
error on a failed submission, and conveying errors by more than colour alone. Those
are the behaviours this module is built to add.

It is a front-end accessibility enhancement with no content or access-control role
of its own, and it has no dependencies. One caveat worth keeping in mind: Drupal
core has improved its own form-error accessibility across recent releases, so on a
current core version some of this may already be handled — check what the module
still adds on your specific version rather than assuming the whole gap is still open.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. Enable the module and it improves the error
reporting on your site's forms automatically. To confirm the benefit, submit a form
with errors (a registration, contact, or checkout form is a good test) using a
keyboard and a screen reader, and check that focus moves to the error and that each
invalid field's message is announced when you reach it.
