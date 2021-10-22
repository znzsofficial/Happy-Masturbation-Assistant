require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"
import "android.content.res.ColorStateList"
import "android.app.AlertDialog"
import "android.net.Uri"
--对话框标题
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "android.graphics.drawable.*"
import "com.androlua.LuaDrawable"
import "android.graphics.drawable.ShapeDrawable"
import "android.graphics.drawable.shapes.RoundRectShape"
import "layout"
import "module"
import "update"
activity.setTheme(android.R.style.Theme_Material)
activity.setContentView(loadlayout("layout"))
activity.getActionBar().setSubtitle('注意节制')
activity.ActionBar.setBackgroundDrawable(ColorDrawable(0xff1976D2))
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
--分割状态栏，去除阴影效果,若想改颜色必用此效果}
activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS | WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
--设置状态栏背景颜色
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff1976D2);
--设置过渡动画
activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
times.getPaint().setFakeBoldText(true)
card0.foreground=波纹特效v2(0x4Fffffff)
clean.foreground=波纹特效v2(0x4Fffffff)
adv.foreground=波纹特效v2(0x4Fffffff)
diy.foreground=波纹特效v2(0x4fffffff)


--启动时读取数据
读取数据(mysp)
local a=tonumber(sp.getString("user",""))
if a==nil then
  a=0--初始化
  储存数据(tostring(a),mysp)
  times.Text="您还没有自慰哦"
 elseif a==0
  times.Text="您还没有自慰哦"
 else
  times.Text="您已自慰"..sp.getString("user","").."次"
end


--数据增加
card0.onClick=function()
  dialog=AlertDialog.Builder(this)
  .setTitle("标题")
  .setCancelable(true)
  --.setMessage([[]])
  .setPositiveButton("是的",{onClick=function(v)
      数据增加(1)
  end})
  .setNeutralButton("取消",{onClick=function(v)
  end})
  .show()
  dialog.create()
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xFFFF3F5F)
  dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xFF009788)
  --更改Title颜色
  import "android.text.SpannableString"
  import "android.text.style.ForegroundColorSpan"
  import "android.text.Spannable"
  sp = SpannableString("您确定已经进行了自慰吗？")
  sp.setSpan(ForegroundColorSpan(0xff000000),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  dialog.setTitle(sp)
  弹窗圆角(dialog.getWindow(),0xffffffff)

end


--重置次数
clean.onClick=function()
  读取数据(mysp)
  local b=tonumber(sp.getString("user",""))
  b=0
  储存数据(tostring(b),mysp)
  times.Text="您还没有自慰哦"
  add.setVisibility(View.VISIBLE)
end


adv.onClick=function()
  dialog=AlertDialog.Builder(this)
  .setTitle("标题")
  .setCancelable(true)
  --.setMessage([[]])
  .setPositiveButton("自动开冲",{onClick=function(v)
      ti=Ticker()
      ti.Period=100
      ti.onTick=function()
        数据增加(1)
        震动(20)
      end
      ti.start()
      function onPause()
        ti.stop()
      end
      function onStop()
        ti.stop()
      end
  end})
  .setNegativeButton("直接冲死",{onClick=function(v)
      数据增加(99999)
      print("你不要命了？")
      震动(3000)
  end})
  .setNeutralButton("取消",{onClick=function(v)
  end})
  .show()
  dialog.create()
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xFFFF3F5F)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xFF5F99FF)
  dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xFF009788)
  --更改Title颜色
  sp = SpannableString("请选择您的自慰方式")
  sp.setSpan(ForegroundColorSpan(0xff000000),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  dialog.setTitle(sp)
  弹窗圆角(dialog.getWindow(),0xffffffff)
end


diy.onClick=function()
  activity.newActivity("diyzd")
  activity.finish()
end


web.loadUrl("https://ip.znzsofficial.top")--加载网页


local item={
  {MenuItem,
    title="关于",
    id="about"},
}


function onCreateOptionsMenu(menu)
  local id={}
  loadmenu(menu,item,id,1)
  onMenuItemSelected=function(num,item)
    local itemname=tostring(item)
    if itemname=="关于" then
      times.Text="开发者:智商封印official™"
      水珠动画(card0,1000)
      --[[elseif itemname=="运行" then
      runcode(editor.Text)
     elseif itemname=="格式化" then
      editor.format()
     elseif itemname=="保存" then
      editor.format()]]
    end
  end
end



import "android.net.Uri"
import "android.content.ComponentName"
import "android.content.Intent"
import "android.content.pm.ShortcutInfo"
import "java.util.ArrayList"

function 判断跳转()
  if jump==1 then
    activity.newActivity("tick")
    activity.finish()
   elseif jump==2 then
    activity.newActivity("diyzd")
    activity.finish()
   else
  end
end

--[[图标快捷方式(App Shortcuts)分为两种:

Static shortcuts(静态快捷方式)
Dynamic shortcuts(动态快捷方式)]]

if Build.VERSION.SDK_INT >= 25 then

  --创建Intent对象
  intent1 = Intent(Intent.ACTION_MAIN);
  --ComponentName设置应用之间跳转      包名(这里直接获取程序包名),   包名+类名(AndroLua打包后还是这个)
  intent1.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent1.setData(Uri.parse("num1"));
  --intent1.setData(Uri.parse('tel://10086'));
  --当快捷方式创建完成之后,点击图标跳转到拨打拨打电话的页面
  --既可以不需要在onNewIntent回调设置点击事件

  intent2 = Intent(Intent.ACTION_MAIN);
  intent2.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent2.setData(Uri.parse("num2"));

  --id,快捷方式名字,快捷方式被点击后执行的intent,快捷方式的图标地址
  SHORTCUT_TABLE={
    {"ID1","自定义震动",intent2,activity.getLuaDir().."/res/vibrate.png"},
    --{"ID2","自慰计时",intent1,activity.getLuaDir().."/res/alarm-check.png"},
  }

  --动态的Shortcut,获取ShortcutManager,快捷方式管理器
  --提供了添加,移除,更新,禁用,启动,获取静态快捷方式,获取动态快捷方式,获取固定在桌面的快捷方式等方法
  scm = activity.getSystemService(activity.SHORTCUT_SERVICE);

  --循环添加到对象ArrayList
  infos = ArrayList();
  for k,v in pairs(SHORTCUT_TABLE) do
    si = ShortcutInfo.Builder(this,v[1])
    --设置图标
    .setIcon(Icon.createWithBitmap(loadbitmap(v[4])))
    --快捷方式添加到桌面显示的标签文本
    .setShortLabel(v[2])
    --长按图标快捷方式显示的标签文本(既快捷方式名字)
    .setLongLabel(v[2])
    .setIntent(v[3])
    .build();
    infos.add(si);
  end

  --添加快捷方式
  scm.setDynamicShortcuts(infos);

  --移除快捷方式
  --scm.removeDynamicShortcuts(infos);

  --print("快捷方式已创建,不信去长按图标")

  --Intent回调设置点击事件
  function onNewIntent(intent)

    --获得传递过来的数据并转化为字符串
    local uriString = tostring(intent.getData())

    --给每个Intent项目对应Data赋予点击事件
    --[[if "num1"==uriString then
      jump=1
      判断跳转()
     elseif "num2"==uriString then
      jump=2
      判断跳转()
    end]]
    if "num2"==uriString then
      jump=2
      判断跳转()
    end
  end
end
--一.了解AndroLua运行流程

--1.进入Welcome(Activity)

--2.进入Main(Activity),运行main.lua

--3.首先运行main.lua里面的onNewIntent(intent)方法

--4.如果没有onNewIntent(intent)方法,则忽略






cimes.getPaint().setFakeBoldText(true)
std.foreground=波纹特效v2(0x4Fffffff)
stt.foreground=波纹特效v2(0x4Fffffff)
stu.foreground=波纹特效v2(0x4Fffffff)
stu.setVisibility(View.INVISIBLE)

std.onClick=function()
  stdm=tonumber(os.time())
  cimes.Text="自慰开始：您已经开始冲了"
  ti=Ticker()
  ti.Period=1000
  ti.onTick=function()
    stde=(tostring(tonumber(os.time())-stdm))
    cimes.Text="自慰中：您已经持续了"..stde.."秒了"
  end
  ti.start()
  if upo==1 then
    水珠动画(stu,1000)
    task(1000,function()
      stu.setVisibility(View.INVISIBLE)
      upo=0
    end)
   else
  end
end


stt.onClick=function()
  if stde==nil then
    提示("你怎么这么快？")
   else
    ti.stop()
    cimes.Text="自慰结束：您本次自慰用时"..stde.."秒"
    if upo==1 then
     else
      stu.setVisibility(View.VISIBLE)
      缩放动画(stu)
      upo=1
    end
  end
end

stu.onClick=function()
  数据增加(1)
  水珠动画(stu,1000)
  task(1000,function()
    stu.setVisibility(View.INVISIBLE)
  end)
end

