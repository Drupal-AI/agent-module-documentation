# Video Filter Example — agent index

Demo submodule of Video Filter. Ships exactly one thing: a sample `@VideoFilter` codec
(`src/Plugin/VideoFilter/ExampleCodec.php`, id `example`) as reference for writing your own provider
codec. No config, no hooks, no permissions, no services.

- How codecs work and how to write one → see the parent's
  [../../../../1.0.x/agent/plugins/codec.md](../../../../1.0.x/agent/plugins/codec.md)

Key facts:
- Codec `example`: regexp `/drupal\.org\/project\/([0-9a-z_]+)/i`, ratio `4/3`, `iframe()` returns
  `src = https://www.drupal.org/project/<match[1]>`.
- Depends (de facto) on `video_filter` for `VideoFilterBase` and the plugin manager, though its
  `info.yml` lists no explicit `dependencies`.
- `core_version_requirement: ^9 || ^10` (no `^11`). Demo/reference only — not for production.
- Enable: `drush en video_filter_example -y`, then tick "Example" in a format's Video Filter plugins.
