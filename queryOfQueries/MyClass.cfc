/**
*
* @file  queryOfQueries/MyClass.cfc
* @author Edmilton Neves
* @description
* http://wiki.coldbox.org/wiki/DevelopmentBestPractices.cfm
*/

component output="false" displayname="MyClass"  {

  public function init(){
    return this;
  }

  public function getLanguages() {
    local.result = "";
    local.qLang = queryNew("id,name", "Integer,Varchar",
                        [
                          {id=1,name="CFML"},
                          {id=2,name="Ruby"},
                          {id=3,name="Python"},
                          {id=4,name="Perl"},
                          {id=5,name="Java"}
                        ]
      );

    local.qoq = new Query();

    local.qoq.setAttributes( originalResult = local.qLang, DBType="query", Name="exampleQuery" );

    local.result = local.qoq.execute( sql = "SELECT * FROM originalResult ORDER BY name").getResult();

    return local.result;
  }
}