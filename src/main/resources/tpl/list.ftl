<#noparse><#include "/WEB-INF/views/common/common.html"/> <@layout></#noparse>
<link rel="stylesheet" href="<#noparse>${ctx!}</#noparse>/res/layer/theme/default/layer.css">
</head>
<body>
<script type="text/javascript">

    // 新增 model
    function newModel() {
        layerTools.layerIframe('fa-plus','新建', '<#noparse>${ctx!}</#noparse>/${(meta.claLowName)!}/newModel', '800px', '500px')
    }

    // 编辑 model
    function editModel() {
        var row = $("#dg").treegrid("getSelected");
        if (row != null) {
            layerTools.layerIframe('fa-pencil','编辑', '<#noparse>${ctx!}</#noparse>/${(meta.claLowName)!}/newModel?id=' + row.id, '800px', '500px')
        } else {
            layerTools.layerMsg('请选择一行数据进行编辑');
        }
    }

    // 删除 model
    function deleteModel() {
        var row = $("#dg").datagrid("getSelected");
        if (row != null) {
            layerTools.confirm(3, '删除', '您确定要删除选中的记录吗?', function () {
                $.post('<#noparse>${ctx!}</#noparse>/${(meta.claLowName)!}/deleteAction?id=' + row.id, function (data) {
                    layerTools.layerMsg(data, function () {
                        $('#dg').datagrid('reload');
                    });
                }, "text");
            });

        } else {
            layerTools.layerMsg('请选择一行进行删除');
        }
    }

    //条件查询
    function queryModel() {
        var queryParams = {};
        queryParams['search_LIKE_test'] = $("#test").textbox("getValue");
        $('#dg').datagrid('load', queryParams);
    }
</script>
<table id="dg" class="easyui-datagrid"
       url="<#noparse>${ctx!}</#noparse>/${(meta.claLowName)!}/query"
       toolbar="#tb" rownumbers="true" border="false"
       fit="true" pagination="true" singleSelect="true"
       pageSize="40" pageList="[20,40]">
    <thead>
    <tr>
                   <th data-options="field:'${(meta.primaryKey)!}',checkbox:true"></th>
        <#list meta.cols as col>
               <#if !(col.isPrimaryKey)?? >
                   <th field="${(col.name)!}" width="100"><#if (col.remarks)??>${(col.remarks)!}<#else>${(col.name)!}</#if></th>
               </#if>
        </#list>
    </tr>
    </thead>
</table>

<div id="tb">
    <a onclick="newModel()" href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
    <a onclick="editModel()" href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
    <a onclick="deleteModel()" href="#" class="easyui-linkbutton  " iconCls="icon-remove" plain="true">删除</a>
    <span id="enterSpan" class="searchInputArea">
          <input id="test" prompt="test" class="easyui-textbox" style="width:120px; ">
          <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryModel()">搜索</a>
    </span>
</div>
<script src="<#noparse>${ctx!}</#noparse>/res/layer/layer.js"></script>
<script src="<#noparse>${ctx!}</#noparse>/res/js/layer-tools.js"></script>
<script>
    // enter监听查询
    $("#enterSpan").on("keydown",function(e){
        if(e.keyCode==13){
            queryModel();
        }
    })
</script>
<#noparse>
</@layout>
</#noparse>
