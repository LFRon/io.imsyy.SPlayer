#!/bin/bash
ll-builder build --skip-output-check && ll-builder export --layer -z lzma
