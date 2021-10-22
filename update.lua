require "import"
import "android.text.Html"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "android.graphics.drawable.ColorDrawable"




公告url="https://sharechain.qq.com/fbd2fba15ed6d610721661038924b900"
Http.get(公告url,nil,"utf8",nil,function(code,content,cookie,header)
  if code==200 then
    content=content:match("\"html_content\":(.-),"):gsub("\\u003C/?.-%>",""):gsub("\\\\","&revs;"):gsub("\\n","\n"):gsub("&nbsp;"," "):gsub("&lt;","<"):gsub("&gt;",">"):gsub("&quot;","\""):gsub("&apos;","'"):gsub("&revs;","\\"):gsub("&amp;","&");
    --过滤,支持换行，注意每一行以中文句号结尾。
    content=content:gsub("。","\n") or content;
    --状态
    开关=content:match("【状态】(.-)【状态】")
    --公告内容
    公告=content:match("【内容】(.-)【内容】")
    链接=content:match("【链接】(.-)【链接】")
    版本=content:match("【版本:(.-):END】")
    版本名=this.getPackageManager().getApplicationLabel(this.getPackageManager().getApplicationInfo(this.getPackageName(),0))
    版本号=tostring(this.getPackageManager().getPackageInfo(this.getPackageName(),((782268899/2/2-8183)/10000-6-231)/9).versionName)
    if 版本号==版本 then
     else
      if 开关=="开" then
        yuxuan=
        {
          LinearLayout,
          layout_height="fill";
          layout_width="fill";
          orientation="vertical",
          -- gravity="center";
          id="dc",
          {
            CardView;
            layout_height="wrap";
            layout_width="80%w";
            backgroundColor="#FFffffff";
            layout_gravity="center";
            id="card";
            radius="8dp",
            {
              LinearLayout,
              orientation="vertical",
              layout_width="fill",
              layout_height="fill",

              --图片布局
              {
                LinearLayout,
                orientation="horizontal",
                layout_height="8%h";
                layout_width="fill";
                gravity="center";
                backgroundColor="#FF009688";
                {
                  TextView;
                  textSize="20sp";
                  --layout_height="match_parent",
                  --layout_marginTop="10dp";
                  --   layout_marginLeft="10dp";
                  --    layout_marginRight="10dp";
                  textColor="#ffffffff";
                  text="检测到更新:"..版本,

                  --text=Html.fromHtml("<b><sub>"..公告.."</sub></b>"),
                  --textStyle="bold",
                  --textScaleX="1.5f",
                };
              } ;

              {
                TextView;
                textSize="14sp";
                --layout_height="8%h";
                layout_height="match_parent",
                layout_marginTop="5dp";
                layout_marginLeft="10dp";
                layout_marginRight="10dp";
                textColor="#FF808080";
                text=公告,
                --text=Html.fromHtml("<b><sub>"..公告.."</sub></b>"),
                --textStyle="bold",
                --textScaleX="1.5f",
              };

              --按钮布局
              {
                LinearLayout,
                orientation="horizontal",
                gravity="center|bottom";
                layout_width="fill",
                layout_height="match_parent",
                --  layout_marginTop="15dp";
                layout_marginBottom="8dp";
                backgroundColor="#ffffffff";
                {
                  CardView,
                  layout_width="105dp",
                  layout_height="38dp",
                  radius="10dp";
                  CardElevation="5dp";
                  backgroundColor="#E91E63";
                  layout_gravity="center|left";
                  --layout_marginLeft="15%w";
                  id="sj",

                  {
                    TextView;
                    gravity="center";
                    text="取消";
                    textColor="0xffffffff";
                    layout_gravity="center";
                  };
                },
                {
                  CardView,
                  layout_width="105dp",
                  layout_height="38dp",
                  layout_marginLeft="8%w";
                  backgroundColor="#E91E63";
                  radius="10dp";
                  CardElevation="5dp";
                  layout_gravity="center|right";
                  id="sj1",

                  {
                    TextView;
                    gravity="center";
                    text="更新";
                    textColor="0xffffffff";
                    layout_gravity="center";
                  };
                },
              },


            },
          },
        }


        dialog= AlertDialog.Builder(this)
        dialog1=dialog.show()
        dialog1.getWindow().setContentView(loadlayout(yuxuan));
        --  doalog1.setCancelable(false)
        dialog1.setCanceledOnTouchOutside(false)
        dialog1.setCancelable(false)
        dialog1.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000));


        sj.onClick=function(v)
          dialog1.dismiss()
        end
        sj1.onClick=function(v)
          dialog1.dismiss()
          viewIntent = Intent("android.intent.action.VIEW",Uri.parse(链接))
          activity.startActivity(viewIntent)
        end

        sj1.foreground=波纹特效v2(0xffdddddd)
        sj.foreground=波纹特效v2(0xffdddddd)

       elseif 开关=="关" then
        return true
      end
    end
   else
    提示"网络连接错误，请检查网络"
  end
end)




