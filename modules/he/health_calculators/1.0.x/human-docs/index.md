# Body Health Calculators — manual setup guide

**Body Health Calculators** (`health_calculators`) is an **umbrella package**.
The top-level module carries no functionality of its own — it exists to group a
family of front-end health-metric calculators, each shipped as a submodule, and
to act as their shared parent. You enable the base module plus whichever
calculator submodules you want.

In this release the one bundled calculator is the **Caffeine Calculator**
(`caffeine_calculator`). It gives visitors a public form to pick a drink and
enter a serving size, then estimates the caffeine in that serving and shows a
recommended daily caffeine amount based on age, weight, and any restricting
medical condition. Site administrators configure the list of drinks and their
caffeine content. More calculators are planned to join the package over time.

> **Not health advice.** As the module itself states, these calculators are
> indicators only — visitors should not rely on them for medical advice. Consider
> making that clear on the pages where you display them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the package with Composer and
   enable the calculator submodule you want.
2. [Configuration](configuration/index.md) — setting up the Caffeine Calculator's
   drink list and finding its public form.

## Where it lives in the admin menu

The umbrella module adds no admin page of its own. The functionality — and its
settings — come from the calculator submodule you enable. With the **Caffeine
Calculator** on, its admin settings live at **Configuration → Development
tools → Caffeine Calculator** (`/admin/config/tools/caffeine-calculator`), and
its public form is served at `/body-calculators/caffeine-calculator`. See
[Configuration](configuration/index.md).
