#!/usr/bin/env bash
# Introspection SETUP: create three node types - og_grp (registered as an OG GROUP),
# og_gcontent (given the og_audience field, i.e. GROUP CONTENT) and og_plain (neither) - so the
# agent must inspect og.settings / the field config on the live site to classify them.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  use Drupal\og\OgGroupAudienceHelperInterface;
  foreach (["og_grp" => "OG Probe Group Type", "og_gcontent" => "OG Probe Group Content", "og_plain" => "OG Probe Plain"] as $id => $label) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $label])->save(); }
  }
  if (!Og::isGroup("node", "og_grp")) { Og::groupTypeManager()->addGroup("node", "og_grp"); }
  Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, "node", "og_gcontent");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node type og_grp is an OG group, og_gcontent has og_audience, og_plain is neither"
