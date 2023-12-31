// package javaposse.jobdsl.plugin

// import hudson.Extension
// import jenkins.model.GlobalConfiguration
// import jenkins.model.GlobalConfigurationCategory
// import net.sf.json.JSONObject
// import org.kohsuke.stapler.StaplerRequest

// @Extension
// class GlobalJobDslSecurityConfiguration extends GlobalConfiguration {
//     GlobalConfigurationCategory getCategory() {
//         GlobalConfigurationCategory.get(GlobalConfigurationCategory.Security)
//     }

//     boolean useScriptSecurity = false

//     GlobalJobDslSecurityConfiguration() {
//         load()
//     }

//     @Override
//     boolean configure(StaplerRequest req, JSONObject json) {
//         useScriptSecurity = json.has('useScriptSecurity')
//         save()
//         true
//     }
// }

import javaposse.jobdsl.plugin.GlobalJobDslSecurityConfiguration
import jenkins.model.GlobalConfiguration

println "--> disabling scripts security for job dsl scripts"

GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity=false