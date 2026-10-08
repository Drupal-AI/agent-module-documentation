# Configuration

Configuring Entity Template means defining the **builders** and **template
blueprints** that drive the build flow.

## Define a builder and blueprints

Using the module's admin UI, create a **builder**. A builder holds one or more
**template blueprints**: pre‑defined entity templates whose values can include
**tokens** filled from **parameters** collected during the build. Set up the
parameters the build should ask for, the blueprint(s) a user may choose from, and
the tokenised field values each blueprint supplies.

## Run the build flow

Once a builder is configured, users go through the build UI under
`/entity_template/build/*`, which walks them through three stages:

1. **Parameters** — supply the values the template's tokens need.
2. **Select** — choose which blueprint to build from.
3. **Edit** — land on a normal entity edit form, pre‑filled from the chosen
   template, and save to create the new entity.

## Access & who can do what

Configuring builders and blueprints is governed by the module's permissions —
**Administer template builders** and **Administer template blueprints** — so grant
those only to users you trust to define templates. Decide deliberately which users
should be able to run the build flow that creates entities, and confirm the
behaviour matches your expectations on a staging environment before relying on it in
production. As a pre‑release module it is not covered by Drupal's security advisory
policy, so validate it against your own requirements first.
