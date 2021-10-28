global with sharing class NHN_Exception extends Exception{
    //Constructor with Standard Exception and LWC handling
    global NHN_Exception (String methodIdentifier, String message) {
        
        // If we're in a test context, throw the original exception
        if (Test.isRunningTest()) {
            throw new NHN_Exception(message);
        } else {
            // Check session type before throwing error. If an Aura exception is thrown in an non-aura context, SF with throw an unexpected exception type error and the underlying error/exception is obscured
            String sessionType = Auth.SessionManagement.getCurrentSession().get('SessionType');
            if (sessionType=='Aura' || sessionType=='ChatterNetworks') {
                throw new LWC_Exception(methodIdentifier, message, null);
            } else {
                throw new NHN_Exception(message);
            }
        }
  
    }

    //Constructor with Standard Exception and LWC handling
    global NHN_Exception (String methodIdentifier, String message, Exception e) {
        
        // If we're in a test context, throw the original exception
        if (Test.isRunningTest()) {
            throw new NHN_Exception(message, e);
        } else {
            String sessionType = Auth.SessionManagement.getCurrentSession().get('SessionType');
            System.debug('Auth.SessionManagement.getCurrentSession: '+sessionType);
            if (sessionType=='Aura' || sessionType=='ChatterNetworks') {
                throw new LWC_Exception(methodIdentifier, message, e, null);
            } else {
                throw new NHN_Exception(message, e);
            }
        }
    }
}
