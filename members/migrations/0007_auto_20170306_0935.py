# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-03-06 09:35
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('members', '0006_auto_20170306_0935'),
    ]

    operations = [
        migrations.AlterField(
            model_name='individualmember',
            name='name',
            field=models.CharField(db_index=True, max_length=250),
        ),
    ]
