<?php
use Drupal\media\Entity\MediaType;
if (MediaType::load('remote_video')) { print "already exists\n"; return; }
$mt = MediaType::create(['id' => 'remote_video', 'label' => 'Remote video', 'source' => 'oembed:video']);
$mt->save();
$source = $mt->getSource();
$field = $source->createSourceField($mt);
$field->getFieldStorageDefinition()->save();
$field->save();
$mt->set('source_configuration', ['source_field' => $field->getName()])->save();
print "created media.type.remote_video with source field " . $field->getName() . "\n";
