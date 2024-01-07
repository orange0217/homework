agent:
  resources:
    requests:
      cpu: "512m"
      memory: "512Mi"
    limits:
      cpu: "2000m"
      memory: "2048Mi"
controller:
  #ingress:
   # enabled: true
   # ingressClassName: nginx
   # hostName: jenkins.starmooc.net
  adminPassword: "password123"
  installPlugins:
    - kubernetes:4029.v5712230ccb_f8
    - workflow-aggregator:596.v8c21c963d92d
    - git:5.1.0
    - configuration-as-code:1670.v564dc8b_982d0
  additionalPlugins:
    - prometheus:2.2.3
    - kubernetes-credentials-provider:1.211.vc236a_f5a_2f3c
    - job-dsl:1.84
    - github:1.37.1
    - github-branch-source:1725.vd391eef681a_e
    - gitlab-branch-source:660.vd45c0f4c0042
    - gitlab-kubernetes-credentials:132.v23fd732822dc
    - pipeline-stage-view:2.33
    - sonar:2.15
    - pipeline-utility-steps:2.16.0

  JCasC:
    defaultConfig: true
    configScripts:
      welcome-message: |
       jenkins:
         systemMessage: Welcome to xxxxxxxx!
      jenkins-casc-configs: |
        unclassified:
          githubpluginconfig:
            configs:
              - name: "GitHub"
                apiUrl: "https://api.github.com"
                credentialsId: "github-personal-token"
                manageHooks: true
      example-job: |
        jobs:
          - script: >
              multibranchPipelineJob('small-case') {
                branchSources {
                  github {
                    // The id option in the Git and GitHub branch source contexts is now mandatory (JENKINS-43693).
                    id('multitest') // IMPORTANT: use a constant and unique identifier
                    scanCredentialsId('github-user-pass')
                    repoOwner('orange0217')
                    repository('homework')
                  }
                }
                triggers {
                  periodicFolderTrigger {
                    interval("1")
                    }
                }
                orphanedItemStrategy {
                  discardOldItems()
                }
              }
