# Configuration

Setting up AI Entity Intake has three parts: a module-wide default, the entity
definitions that describe what the AI may create, and the intake profiles that
decide who may create what. After that, the intake-to-draft workflow runs.

## Settings

Go to **Configuration → AI → Entity Intake** (`/admin/config/ai/entity-intake`),
which requires the restricted **Administer AI entity intake** permission.

- **Provider / model** (`provider_model`) — the module-wide default AI provider
  and model, expressed as one of the AI module's option strings. It is used
  whenever an intake profile does not set its own override. Leave a profile
  without an override to inherit this; leave this unset to fall back to the AI
  module's own default for structured-chat output.

## Entity definitions

At `/admin/config/ai/entity-intake/definitions` you create **AI entity
definitions**. Each definition describes:

- The **target entity type and bundle** the AI is allowed to create (for
  example, an Article node or a specific taxonomy term).
- The **fields** the AI may fill for that bundle. Only fields you list here are
  ever populated — this is how you keep the AI within bounds.
- Optional **per-field model overrides**, used by the multi-pass extractor when
  a particular field benefits from a different model.

## Intake profiles

At `/admin/config/ai/entity-intake/profiles` you create **intake profiles**.
Each profile:

- Scopes **which entity definitions** it is allowed to create, so different
  profiles can target different content.
- Can set a **profile-level provider/model override** that beats the module
  default above.
- Automatically mints a dynamic permission named **Use AI intake profile
  {id}**. Grant this permission to the roles you want to be able to submit
  intakes against that profile.

## Which provider is used

When an intake runs, the module resolves the provider and model in this order:
the **profile override** first, then the **module-wide setting** above, and
finally the **AI module's default** for structured-chat output. That lets you
set one sensible default and override it only where it matters.

## Permissions

AI Entity Intake layers several permissions:

- **Administer AI entity intake** *(restricted)* — manage settings, definitions
  and profiles.
- **Use AI intake profile {id}** *(one per profile)* — create intakes against
  that profile.
- **View any AI intake** — see intakes that aren't your own.
- **Review AI entity intake suggestions** — open the review screen and act on
  suggestions.
- **Create entities from AI intake** — turn an approved suggestion into a draft;
  the target entity's own create access must also allow it.

Access is enforced by the module's access handlers: viewing or deleting an
intake needs *View any AI intake* or being the owner while still holding the
profile; reviewing needs the review permission; creating a draft needs both the
create permission and the target entity's normal create access.

## The workflow, step by step

1. A user who holds a profile's permission creates an intake at
   `/admin/content/ai-intake/add` and pastes in the source text.
2. Cron runs the `ai_entity_intake_extraction` queue. The multi-pass extractor
   calls the AI provider — a routing pass, a field pass, and a per-entity pass —
   and stores normalized suggestions, optionally flagging duplicates of existing
   entities.
3. A reviewer opens the intake's **review** screen, dismisses suggestions they
   don't want, and clicks **Use** on the ones they do. Drupal's native add form
   opens, pre-filled with the suggested values; saving it creates a normal draft
   entity.
4. Failed or dismissed intakes can be **requeued** for another attempt.

Because approval always routes through the standard add form, every entity that
gets written is subject to the usual entity access checks — the AI never bypasses
them.
