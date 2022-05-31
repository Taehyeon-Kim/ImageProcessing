# ImageProcessing
그냥 이미지 처리.. 실험..🌅

## UIKit - UIImage

<img src = "https://user-images.githubusercontent.com/61109660/171152069-db1cb9ee-5ea3-48c1-b05d-44e4d9127ec0.png" width = "700" />
<img src = "https://user-images.githubusercontent.com/61109660/171152079-4b1a3f4f-599d-417e-8aaf-c5b6b2456793.png" width = "700" />

`iOS 15.0` 이상부터 UIImage의 축소판(Thumbnail)을 리턴해주는 인스턴스 메서드를 제공합니다. 동기 및 비동기 기능을 모두 제공하고 있는데요.

### 실험) preparingThumbnail 함수를 이용했을 때, 메모리 오버헤드를 얼마나 줄일 수 있을까요? 매우 큰 이미지를 전체 크기로 디코딩 했을 때 발생하는 오버헤드를 줄여봅시다.

iOS 15부터 생긴 메서드를 이용해보기 위해서 프로젝트를 하나 만들었습니다. 그리고 간단한 테스트를 위해서 Image를 하나 넣어줬어요.
![스크린샷 2022-05-31 오후 7 03 33](https://user-images.githubusercontent.com/61109660/171152253-b5994fc2-8bd1-417f-8fe4-8a8434e2a0fc.png)

Image 사이즈는 보시다시피 매우 큽니다.

![스크린샷 2022-05-31 오후 7 04 25](https://user-images.githubusercontent.com/61109660/171152316-8c418c01-6922-4395-a8bf-89786e12d63c.png)

휴대폰 사이즈와는 비교도 안 되는 픽셀 사이즈를 가지고 있죠. 그래서 분명 사이즈 조정이 필요할 것입니다. 간단하게는 ImageView의 ContentMode를 조정하여 View의 크기에 맞춰버리는 방식이 있을텐데요. 그것은 나의 휴대폰에게 너무나 미안한 일입니다. 메모리 어떡할거야 🥲

근데 너무나 고맙게 위에서 소개한 메서드를 이용하면 메모리 오버헤드를 줄일 수 있다고 합니다. View의 bounds를 넘어가는 엄청난 크기의 원본 이미지가 있다면 thumbnail 메서드를 이용해서 특정 사이즈로 줄일 수 있다고 하네요. 바로 코드를 작성해보았습니다.

![스크린샷 2022-05-31 오후 7 07 52](https://user-images.githubusercontent.com/61109660/171152397-353ca902-1875-4a7d-b5e1-8d8a5e16305c.png)

간단하게 UIImageView를 올렸구요. 코드도 이어서 보여드리겠습니다. 간단한 테스트를 위해서 그냥 원본 이미지를 디코딩 해줬을 때랑, Thumbnail 함수로 사이즈를 줄인 이미지를 디코딩 해주었습니다.

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originImage = UIImage(named: "sunrise")
        let thumbnail = originImage?.preparingThumbnail(of: CGSize(width: 1000, height: 500))

        // imageView.image = originImage        
        imageView.image = thumbnail
    }

}
```

![스크린샷 2022-05-31 오후 7 09 56](https://user-images.githubusercontent.com/61109660/171152420-436646c1-d4be-4900-80e7-3a4c72260a2f.png)

원본이미지를 넣었을 때입니다.

![스크린샷 2022-05-31 오후 7 10 10](https://user-images.githubusercontent.com/61109660/171152439-1ddfaf5a-6005-486c-9bc8-4d82e4ca2d51.png)

Thumbnail(축소판)이미지를 넣었을 때 입니다. 이미지 1개인데 메모리 사용량 3배 차이 실화입니까..? 아찔하네요. 정말 풀 사이즈의 이미지를 디코딩하는 오버헤드를 많이 줄일 수 있네요. 실험 성공!
