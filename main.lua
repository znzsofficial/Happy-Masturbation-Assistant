require "import"
import {
  "android.app.*",
  "android.os.*",
  "android.widget.*",
  "android.view.*",
  "android.graphics.BitmapFactory",
  "android.graphics.drawable.BitmapDrawable",
  "android.graphics.drawable.ColorDrawable",
  "android.animation.LayoutTransition",
  "android.content.Context",
  "android.util.TypedValue",
  "java.io.FileInputStream",

  "androidx.core.widget.NestedScrollView",
  "androidx.coordinatorlayout.widget.CoordinatorLayout",
  "androidx.viewpager.widget.ViewPager",
  "androidx.appcompat.widget.LinearLayoutCompat",
  "com.google.android.material.appbar.AppBarLayout",
  "com.google.android.material.appbar.MaterialToolbar",
  "com.google.android.material.appbar.CollapsingToolbarLayout",
  "com.google.android.material.card.MaterialCardView",
  "com.google.android.material.bottomnavigation.BottomNavigationView",
  "com.google.android.material.dialog.MaterialAlertDialogBuilder",
  "com.google.android.material.divider.MaterialDivider",
  "com.google.android.material.snackbar.Snackbar",
  "com.google.android.material.textview.MaterialTextView",
  "com.google.android.material.slider.Slider",
  "com.google.android.material.button.MaterialButton",
  "com.google.android.material.floatingactionbutton.ExtendedFloatingActionButton",
  "com.google.android.material.tabs.TabLayout",
  "com.google.android.material.textfield.TextInputEditText",
  "com.google.android.material.textfield.TextInputLayout",

  "github.daisukiKaffuChino.utils.LuaThemeUtil",
  "com.daimajia.androidanimations.library.Techniques",
  "com.daimajia.androidanimations.library.YoYo",
  "com.github.mikephil.charting.charts.PieChart",
  "com.github.mikephil.charting.components.Description",
  "com.github.mikephil.charting.data.*",
}

--设置主题
activity.setTheme(R.style.Theme_ReOpenLua_Material3)
--初始化颜色
import"com.google.android.material.color.DynamicColors"
DynamicColors.applyIfAvailable(this)
--为了使深色主题效果正常，请不要使用硬编码颜色!
local themeUtil=LuaThemeUtil(this)
MDC_R=luajava.bindClass"com.google.android.material.R"
surfaceColor=themeUtil.getColorSurface()
backgroundc=themeUtil.getColorBackground()
surfaceVar=themeUtil.getColorSurfaceVariant()
titleColor=themeUtil.getTitleTextColor()
primaryc=themeUtil.getColorPrimary()
primarycVar=themeUtil.getColorPrimaryVariant()

--初始化ripple
rippleRes = TypedValue()
activity.getTheme().resolveAttribute(android.R.attr.selectableItemBackground, rippleRes, true)


--函数区--

function getFileDrawable(file)
  fis = FileInputStream(activity.getLuaDir().."/res/"..file..".png")
  bitmap = BitmapFactory.decodeStream(fis)
  return BitmapDrawable(activity.getResources(), bitmap)
end

function dataInput(str,文件名,参数)
  --获取SharedPreferences文件，后面的第一个参数就是文件名，没有会自己创建，有就读取
  local sp = activity.getSharedPreferences(文件名,Context.MODE_PRIVATE)
  --设置编辑
  local editor = sp.edit()
  editor.putString(参数,str).apply()
end

function dataRead(文件名)
  sp = activity.getSharedPreferences(文件名,Context.MODE_PRIVATE)
end

function dataAdd(数据,文件名,参数)
  dataRead(文件名)
  local a=tonumber(sp.getString(参数,""))
  if a==nil then
    a=0
    times.Text="您还没有自慰哦"
   else
    a=a+数据
    dataInput(tostring(a),文件名,参数)
    times.Text="您已自慰"..a.."次"
  end
end

function print(content)
  local _v=Snackbar.make(vpg,content,Snackbar.LENGTH_SHORT).show();
  if vpg.getCurrentItem() == 0 then
    _v.setAnchorView(fab)
   else
    _v.setAnchorView(bottombar)
  end
end


--隐藏输入法
function hiddenInputMethod(inputid)
  import "android.view.inputmethod.InputMethodManager"
  activity.getSystemService(Context.INPUT_METHOD_SERVICE).hideSoftInputFromWindow(inputid.getWindowToken(),0)
end

--主布局区---

layout={
  CoordinatorLayout,
  layout_width="fill",
  layout_height="fill",
  {
    AppBarLayout,
    layout_width="fill",
    layout_height="wrap",
    id="appbar",
    {
      MaterialToolbar,
      id="toolbar",
      layout_scrollFlags="snap",
      background=ColorDrawable(surfaceVar),
      layout_width="fill",
      layout_height="56dp",
      title="求导小助手",
    },
  },
  {
    NestedScrollView,
    layout_width="fill",
    layout_height="fill",
    layout_behavior="@string/appbar_scrolling_view_behavior",
    fillViewport="true",
    backgroundColor=backgroundc,
    {
      LinearLayoutCompat,
      id="content",
      layout_width="fill",
      layout_height="fill",
      orientation="vertical",
      --[
      {
        ViewPager,
        id="vpg",
        layout_width="fill",
        layout_height="fill",
        pages={
          "page_home",
          "page_vibrate",
        },
      },
    },
  },
  {
    BottomNavigationView,
    id="bottombar",
    layout_gravity="bottom",
    layout_width="fill",
    layout_height="wrap",
  },
  {
    ExtendedFloatingActionButton,
    id="fab",
    text="Add",
    onClick="onClickFab",
    icon=getFileDrawable("plus-thick"),
    layout_gravity="bottom|end",
    layout_marginBottom="110dp",
    layout_marginEnd="16dp",
  },
}


--设置布局
activity.setContentView(loadlayout(layout))
--隐藏自带ActionBar
activity.getSupportActionBar().hide()
--配置状态栏颜色
local window = activity.getWindow()
window.setStatusBarColor(surfaceVar)
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
window.setNavigationBarColor(surfaceVar)

--设置Material底栏。谷歌将启用新的BottomAppBar,两者区别不大，故不再作展示
--得益于CoordinatorLayout的强大支持，配合layout_behavior轻松实现滚动隐藏
local bottombarBehavior=luajava.bindClass"com.google.android.material.behavior.HideBottomViewOnScrollBehavior"
bottombar.layoutParams.setBehavior(bottombarBehavior())
bottombar.setLabelVisibilityMode(1)--设置tab样式

--设置底栏项目
bottombar.menu.add(0,0,0,"Home")--参数分别对应groupid homeid order name
bottombar.menu.add(0,1,1,"Vibrator")
--设置底栏图标
bottombar.menu.findItem(0).setIcon(getFileDrawable("home"))--这里findItem取的是home id
bottombar.menu.findItem(1).setIcon(getFileDrawable("vibrate"))

--MaterialToolbar比普通Toolbar更强大的地方在于，它可以脱离Activity使用
local addToolbarMenu=lambda a,b,c,name:toolbar.menu.add(a,b,c,name)
addToolbarMenu(0,0,0,"Statistics")
addToolbarMenu(0,1,1,"About")
addToolbarMenu(0,2,2,"Exit")
--这里展示了标准lua没有的AndroLua+专属语法lambda(匿名函数)
--可以大幅简化重复函数调用。上面的底栏也是可以用lambda添加的。


--初始化区----

--启动时读取数据
dataRead("mysp")
local a=tonumber(sp.getString("base",""))
if a==nil then
  a=0--初始化
  dataInput(tostring(a),"mysp","base")
  times.Text="您还没有自慰哦"
 elseif a==0
  times.Text="您还没有自慰哦"
 else
  times.Text="您已自慰"..sp.getString("base","").."次"
end

--初始化统计数据
sta={"sta0","sta1","sta2","sta3"}
for index,content in pairs(sta) do
  local c=tonumber(sp.getString(content,""))
  if c==nil then
    c=0
    dataInput(tostring(c),"mysp",content)
  end
end
--主页面区

--关于对话框
function About()
  MaterialAlertDialogBuilder(this)
  .setTitle("About this Application")
  .setMessage("Derivable Assistant\n求导小助手\n智商封印official™")
  .setPositiveButton("知道了",nil)
  .show()
end

--顶栏菜单点击监听
import "androidx.appcompat.widget.Toolbar$OnMenuItemClickListener"
toolbar.setOnMenuItemClickListener(OnMenuItemClickListener{
  onMenuItemClick=function(item)
  switch item.getItemId() do
     case 0
      --数据统计及画图
      dataRead("mysp")
      ChartLayout={
        LinearLayoutCompat;
        orientation="vertical";
        {
          PieChart,
          id="mChart",
          layout_width="fill",
          layout_height="300dp",
        },
      }
      MaterialAlertDialogBuilder(this)
      .setTitle("Data Statistics")
      .setView(loadlayout(ChartLayout))
      .setMessage("总次数:"..sp.getString("base","").."\n0-1分钟:"..sp.getString("sta0","").."\n1-10分钟:"..sp.getString("sta1","").."\n10-30分钟:"..sp.getString("sta2","").."\n30分钟以上:"..sp.getString("sta3",""))
      .setIcon(getFileDrawable("chart-bar-stacked"))
      .setPositiveButton("知道了",nil)
      .show()

      --初始化饼图
      --项目地址https://github.com/PhilJay/MPAndroidChart
      mChart.setUsePercentValues(true)
      mChart.getDescription().setEnabled(false)
      mChart.setDrawEntryLabels(true)
      mChart.setExtraOffsets(5, 10, 5, 5)
      mChart.setDragDecelerationFrictionCoef(0.95)
      mChart.setDrawHoleEnabled(true)
      mChart.setHoleColor(backgroundc)
      mChart.setTransparentCircleColor(backgroundc)
      mChart.setTransparentCircleAlpha(110)
      mChart.setDrawCenterText(true)
      mChart.setRotationAngle(0)
      mChart.setRotationEnabled(true)
      mChart.setHighlightPerTapEnabled(true)
      local enTire=tonumber(sp.getString("base",""))
      local pieZero=tonumber(sp.getString("sta0",""))/enTire
      local pieOne=tonumber(sp.getString("sta1",""))/enTire
      local pieTwo=tonumber(sp.getString("sta2",""))/enTire
      local pieThree=tonumber(sp.getString("sta3",""))/enTire

      local entries={}
      table.insert(entries,PieEntry(pieZero, "item1"))
      table.insert(entries,PieEntry(pieOne, "item2"))
      table.insert(entries,PieEntry(pieTwo, "item3"))
      table.insert(entries,PieEntry(pieThree, "item4"))
      local set = PieDataSet(entries, "频率分布")
      set.setColors({MDC_R.color.m3_ref_palette_primary60, MDC_R.color.m3_ref_palette_primary70, MDC_R.color.m3_ref_palette_primary80,MDC_R.color.m3_ref_palette_primary90,}, this)
      mChart.setData(PieData(set))
     case 1
      About()
     case 2
      activity.finish()
    end
  end
})

--ViewPager和BottomNavigationView联动
vpg.setOnPageChangeListener(ViewPager.OnPageChangeListener{
  onPageSelected=function(v)
    bottombar.getMenu().getItem(v).setChecked(true)
    if v~=0 then
      YoYo.with(Techniques.ZoomOut).duration(200).playOn(fab)
      task(200,function()fab.setVisibility(8)end)
     else
      fab.setVisibility(0)
      YoYo.with(Techniques.ZoomIn).duration(200).playOn(fab)
    end
end})

bottombar.setOnNavigationItemSelectedListener(BottomNavigationView.OnNavigationItemSelectedListener{
  onNavigationItemSelected = function(item)
    vpg.setCurrentItem(item.getItemId())
    return true
end})


--悬浮按钮点击事件
function onClickFab()
  fab.shrink()
  InputLayout={
    LinearLayoutCompat;
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      MaterialTextView;
      textSize="12sp",
      layout_marginLeft="20dp",
      layout_marginRight="20dp",
      layout_width="match_parent";
      layout_gravity="center",
      text="请输入您本次自慰用时:";
    };
    {
      TextInputEditText;
      layout_marginTop="5dp";
      layout_marginLeft="20dp",
      layout_marginRight="20dp",
      layout_width="match_parent";
      layout_gravity="center",
      inputType="number";
      hint="Seconds";
      id="edit";
    };
  }
  MaterialAlertDialogBuilder(this)
  .setTitle("Tips")
  .setView(loadlayout(InputLayout))
  .setIcon(getFileDrawable("outline_info_black_24dp"))
  .setMessage("您确定已经进行了自慰吗？")
  .setPositiveButton("是的",{onClick=function(v)
      fab.extend()
      numTem=tonumber(tostring((edit.getText())))
      if numTem==nil then
        numTem=0
      end
      if numTem<=60 then
        dataAdd(1,"mysp","sta0")
       elseif numTem>60 and numTem<=600 then
        dataAdd(1,"mysp","sta1")
       elseif numTem>600 and numTem<=1800 then
        dataAdd(1,"mysp","sta2")
       else
        dataAdd(1,"mysp","sta3")
      end
      dataAdd(1,"mysp","base")
      hiddenInputMethod(edit)
  end})
  .setNegativeButton("取消",{onClick=function(v)
      hiddenInputMethod(edit)
      fab.extend()
  end})
  .setOnCancelListener{
    onCancel=function()
      fab.extend()
    end
  }
  .show()
end

--Home区---

times.getPaint().setFakeBoldText(true)
--重置次数
clean.onClick=function()
  MaterialAlertDialogBuilder(this)
  .setTitle("Reset")
  .setIcon(getFileDrawable("refresh"))
  .setMessage("您确定要重置数据吗？")
  .setPositiveButton("是的",{onClick=function(v)
      dataRead("mysp")
      local b=tonumber(sp.getString("base",""))
      local b=0
      dataInput(tostring(b),"mysp","base")
      times.Text="您还没有自慰哦"
      --重置统计数据
      for index,content in pairs(sta) do
        local c=0
        dataInput(tostring(c),"mysp",content)
      end
  end})
  .setNegativeButton("取消",{onClick=function(v)
  end})
  .show()
end


--计时器相关
chronoGraph.getPaint().setFakeBoldText(true)

local numTime = 0
function update()
  numTime = numTime + 1
  chronoGraph.Text="自慰中：您已经持续了"..numTime.."秒了"
end

startButton.onClick=function()
  --判断是否正在计时
  if isTiming==true then
    --初始化开始按钮
    startButton.icon=getFileDrawable("play")
    startButton.text="开始"
    --暂停timer定时器
    chronoGraph.Text="自慰暂停：您本次自慰用时"..numTime.."秒"
    myTimer.Enabled=false
    --计时器状态设为关闭
    isTiming=false
   else
    --显示暂停按钮
    startButton.icon=getFileDrawable("pause")
    startButton.text="暂停"
    --初始化 timer
    --timer 参数 = 执行，延迟，间隔，初始化
    myTimer = timer(function()
      call("update")
    end,200,1000, function()
    end)
    --启动timer定时器
    myTimer.Enabled=true
    --用于判断计时器状态
    isTiming=true
  end
end

endButton.onClick=function()
  --检测是否初始化
  if not myTimer then
    print"请先开始"
    return
  end
  --停止timer定时器
  myTimer.stop()
  myTimer = nil --注销计时器
  chronoGraph.Text=""
  --初始化开始按钮
  startButton.icon=getFileDrawable("play")
  startButton.text="开始"
  --结束弹窗
  MaterialAlertDialogBuilder(this)
  .setTitle("Notice")
  .setIcon(getFileDrawable("outline_info_black_24dp"))
  .setMessage("自慰结束：您本次自慰用时"..numTime.."秒")
  .setPositiveButton("提交",{onClick=function(v)
      if numTime<=60 then
        dataAdd(1,"mysp","sta0")
       elseif numTime>60 and numTime<=600 then
        dataAdd(1,"mysp","sta1")
       elseif numTime>600 and numTim<=1800 then
        dataAdd(1,"mysp","sta2")
       else
        dataAdd(1,"mysp","sta3")
      end
      dataAdd(1,"mysp","base")
  end})
  .setNegativeButton("取消",{onClick=function(v)
  end})
  .show()
  --重置时间
  numTime=0
  --计数器状态设为关闭
  isTiming=false
end



--Vibrator区


--设置震动函数
vibrator=activity.getSystemService(Context.VIBRATOR_SERVICE)
function Vibrate()
  vibrator.vibrate(VibrationEffect.createOneShot(onVibLong,AMP))
end

queCard.onClick=function()
  MaterialAlertDialogBuilder(this)
  .setTitle("Hardware check")
  .setMessage("硬件是否有振动器:"..tostring(vibrator.hasVibrator()).."\n振动器是否支持振幅控制:"..tostring(vibrator.hasAmplitudeControl()))
  .setPositiveButton("知道了",nil)
  .show()
end

--识别无马达设备
if vibrator.hasVibrator()==false then
  cardText.Text="提示:您的设备不支持振动"
  --移除按钮
  VibLin.removeView(vibStart)
 elseif vibrator.hasAmplitudeControl()==false then
  cardText.Text="提示:您的设备不支持振幅控制，但是我懒得给此类设备设置另一种振动实现方式"
  --移除按钮
  VibLin.removeView(vibStart)
 else
end

--初始化时长
onVibLong=100
AMP=255
--按键调节震动强度
function onKeyDown(keycode,event)
  if string.find(tostring(event),"KEYCODE_VOLUME_UP") ~= nil then
    if AMP+10>=255 then
      AMP=255
     else
      AMP=AMP+10
    end
  end
  if string.find(tostring(event),"KEYCODE_VOLUME_DOWN") ~= nil then
    if AMP-10<=1 then
      AMP=1
     else
      AMP=AMP-10
    end
  end
  twoSlider.value=AMP
end
--初始化周期
onVibT=1000
--初始化震动状态
isVibrating=false

zeroSlider.addOnChangeListener({--周期改变事件
  onValueChange=function(view,value,bool)
    onVibT=tonumber(value)
    --将周期转化为时长
    onVibLong=onVibLong*onVibT
    isChanged=true
  end
})
oneSlider.addOnChangeListener({--时长改变事件
  onValueChange=function(view,value,bool)
    --print("正在改变值"..tostring(value))
    onVibLong=tonumber(value)
    --将周期转化为时长
    onVibLong=onVibLong*onVibT
    isChanged=false
  end
})
twoSlider.addOnChangeListener({--强度改变事件
  onValueChange=function(view,value,bool)
    AMP=tonumber(value)
  end
})


--开始震动按钮
function onClickVib()
  if isChanged == true then
    print("修改周期后请修改时长")
    return true
   else
    if isVibrating == false then
      zeroSlider.Enabled=false----禁止滑动
      oneSlider.Enabled=false----禁止滑动
      --twoSlider.Enabled=false----禁止滑动
      myVibrator = timer(function()
        call("Vibrate")
      end,0,onVibT, function()
      end)
      --启动timer定时器
      myVibrator.Enabled=true
      --用于判断计时器状态
      isVibrating=true
      vibStart.icon=(getFileDrawable("stop"))
     else
      --停止震动
      vibrator.cancel()
      zeroSlider.Enabled=true----允许滑动
      oneSlider.Enabled=true----允许滑动
      --twoSlider.Enabled=true----允许滑动
      --初始化开始按钮
      vibStart.icon=getFileDrawable("play")
      --暂停timer定时器
      myVibrator.Enabled=false
      --计时器状态设为关闭
      isVibrating=false
    end
  end
end