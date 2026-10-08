#!/usr/bin/env bash
# Introspection SETUP: build a REAL Organic Groups pair on the live site - node type ogp_grp
# registered as a group and ogp_content carrying the OG audience field - and make sure
# og_prepopulate is enabled, so the agent can inspect which widget the audience field really
# uses and which OG widget plugins actually exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en og_prepopulate -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  use Drupal\og\OgGroupAudienceHelperInterface;
  foreach (["ogp_grp" => "OGP Probe Group Type", "ogp_content" => "OGP Probe Group Content"] as $id => $label) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $label])->save(); }
  }
  if (!Og::isGroup("node", "ogp_grp")) { Og::groupTypeManager()->addGroup("node", "ogp_grp"); }
  Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, "node", "ogp_content");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node type ogp_grp is an OG group; ogp_content has the og_audience field; og_prepopulate enabled"
