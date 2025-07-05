#!/bin/bash

# Install External Secrets Operator via Helm
echo "🔧 Adding External Secrets Helm repo..."
helm repo add external-secrets https://charts.external-secrets.io
helm repo update

echo "🚀 Installing External Secrets Operator..."
helm install external-secrets external-secrets/external-secrets \
  --namespace external-secrets --create-namespace \
  --set installCRDs=true

echo "✅ External Secrets Operator installed successfully in 'external-secrets' namespace!"
