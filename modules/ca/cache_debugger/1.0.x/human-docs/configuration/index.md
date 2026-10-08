# Configuration

Cache Debugger has essentially one control: a switch that turns render cache debugging on
or off.

## Open the configuration page

1. Log in as a user with the **Administer cache debugger configuration** permission.
2. Go to **Configuration → Development → Cache Debugger**, or navigate directly to
   `/admin/config/development/cache-debugger`.

## Toggle render cache debugging

Switch render cache debugging **on** to start appending cache metadata to rendered
elements. Behind the scenes this creates a `services.yml` (copied from
`default.services.yml`) with `debug: true` set. Switch it **off** to stop, which removes
that generated `services.yml` file.

Once it is on, visit any page and view the HTML source: you will see cache **contexts**,
**tags**, and other cache‑related metadata attached to each rendered element, which is what
you use to diagnose why something is or isn't cached.

> **Turn it off when you are done.** Render cache debugging is costly and clutters the
> markup, so leave it enabled only while you are actively investigating, and never on
> production.
