#!/bin/bash  

cd /tmp
# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
##########################################install cert-manager-webhook-dnspod########################################
git clone --depth 1 https://github.com/qqshfox/cert-manager-webhook-dnspod.git
helm upgrade --install -n cert-manager -f /tmp/dnspod-webhook-values.yaml cert-manager-webhook-dnspod ./cert-manager-webhook-dnspod/deploy/cert-manager-webhook-dnspod
kubectl apply -f /tmp/argocd-cert.yaml
kubectl apply -f /tmp/jenkins-cert.yaml

##########################################install jenkins########################################
# install jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo update

# create ns
kubectl create ns jenkins

# service account for kubernetes secret provider
kubectl apply -f /tmp/jenkins-service-account.yaml -n jenkins
# jenkins github personal access token
kubectl apply -f /tmp/github-personal-token.yaml -n jenkins

# jenkins github server(system) pat secret
kubectl apply -f /tmp/github-pat-secret-text.yaml -n jenkins

# install jenkins helm
helm upgrade -i jenkins jenkins/jenkins -n jenkins --create-namespace -f /tmp/jenkins-values.yaml --version "4.6.1"

kubectl apply -f /tmp/jenkins-ingress.yaml
##########################################install crossplane########################################

kubectl apply -f /tmp/crossplane-tf-provider.yaml
kubectl apply -f /tmp/crossplane-tf-provider-config.yaml
##########################################install argocd########################################

kubectl apply -f /tmp/application-set.yaml
kubectl apply -f /tmp/argocd-ingress.yaml

echo "##################################### Access Infrastruct ########################################\n"
echo "Access Jenkins: http://jenkins.${domain}, admin, ${jenkins_password}\n"
echo "Access Argo CD: http://argocd.${domain}, admin, ${argocd_password}\n"
