# AI Validations — manual setup guide

**AI Validations** (`ai_validations`) adds AI-powered validation rules to the
**Field Validation** module. Field Validation lets you attach rules to fields —
"this must be a valid email", "this must not exceed 200 characters", and so on —
that run when a form is submitted. AI Validations extends that toolkit with rules
that hand the field's content to an AI model and let the model judge whether it
meets a criterion you describe in plain language ("is this a polite, professional
tone?", "does this description mention a price?").

You use it wherever a simple pattern or length check isn't enough and you want a
model to evaluate the meaning of what was entered. It plugs into Field
Validation's existing rule interface, so once installed the AI checks appear as
additional rule types alongside the built-in ones. It depends on the **AI**,
**Field Validation**, and core **Image** modules.

Be deliberate about the data path: to evaluate a field, its content is sent to the
configured AI provider (data egress), and the AI model's judgement decides whether
the value passes. Credentials for the provider are handled by the AI module, so
store them as secrets. The module itself has no access-control role. It supports
Drupal 10.4 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Field Validation and the AI module.

## Where it lives in the admin menu

AI Validations does not add a settings page of its own. You configure it through
**Field Validation**: when you add or edit a field validation rule (Field
Validation rulesets are managed under the site's configuration, typically per
field or per entity type), the AI-powered rule types provided by this module
become available to choose. The criterion the AI evaluates is set on the rule
itself.

## How to use it

1. Make sure the **AI** module has a working provider configured, with its API key
   stored as a secret.
2. In Field Validation, create or edit a ruleset for the field you want to guard
   and add one of the AI validation rule types this module provides.
3. Describe the criterion the AI should check for, and save. From then on, when
   that field is submitted its content is sent to the AI provider for evaluation
   and the entry is accepted or rejected based on the model's judgement. Remember
   each validation makes a billed AI call.
